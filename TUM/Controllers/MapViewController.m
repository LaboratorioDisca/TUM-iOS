//
//  MapViewController.m
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "MapViewController.h"
#import "RMMarker.h"
#import "Routes.h"
#import "RMPath.h"
#import "RMAnnotation.h"
#import "Route.h"
#import "ApplicationConfig.h"
#import "RMMBTilesSource.h"
#import "RMMapTiledLayerView.h"
#import "LocalizeMeUIButton.h"
#import <AVFoundation/AVFoundation.h>

#import "RemoteFetcher.h"
#import "Instant.h"

@interface MapViewController () {
    NSMutableDictionary *cachedAnnotations;
    LocalizeMeUIButton *localizeMeButton;
    CLLocationManager *locationFetcher;
    AVAudioPlayer *player;
}

- (void) routesLoad;
- (void) mapCustomization;
- (void) displayAnnotation:(RMAnnotation*)annotation forRoute:(Route*)route;
- (void) placeMapOnUpdatedLocation;
@end


@implementation MapViewController

@synthesize mapView;

- (id) init
{
    if((self = [super init])) {
        
        locationFetcher = [[CLLocationManager alloc] init];
        [locationFetcher setDelegate:self];
        [locationFetcher setDesiredAccuracy:kCLLocationAccuracyBest];
        
        NSError * err;
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"pull.caf"];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] 
                                                         error:&err];
        [player prepareToPlay];
        
        cachedAnnotations = [NSMutableDictionary dictionary];
        
        NSURL *tilesURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"UNAMCU" 
                                                                                 ofType:@"mbtiles"]];
        RMMBTilesSource *offlineSource = [[RMMBTilesSource alloc] initWithTileSetURL:tilesURL];
        
        self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds 
                                          andTilesource:offlineSource 
                                       centerCoordinate:[ApplicationConfig coordinates] zoomLevel:16 maxZoomLevel:20 minZoomLevel:9
                                        backgroundImage:nil];
        
        [self.mapView setDelegate:self];
        [self.view addSubview:mapView];
        
        localizeMeButton = [[LocalizeMeUIButton alloc] init];
        [self.view addSubview:localizeMeButton];
        
        UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(placeMapOnUpdatedLocation)];
        [localizeMeButton addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

- (void)placeMapOnUpdatedLocation
{
    [localizeMeButton blink];
    [RemoteFetcher reloadInstants];
    [player play];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.mapView setCenterCoordinate:[newLocation coordinate] animated:YES];
    [locationFetcher stopUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self mapCustomization];
}

- (void) displayAnnotation:(RMAnnotation *)annotation forRoute:(Route *)route
{
    BOOL annotationIsOnMap = [[self.mapView annotations] containsObject:annotation];
    
    if ([route visibleOnMap]) {
        if (!annotationIsOnMap) {
            [self.mapView addAnnotation:annotation];
        }
    } else {
        if (annotationIsOnMap) {
            [self.mapView removeAnnotation:annotation];
        }
    }
}

/*
 * Loads the given routes into the map
 */
- (void) routesLoad
{
    NSDictionary *routes = [[Routes currentCollection] collection];
    for (NSNumber *index in [routes keyEnumerator]) {
        Route *route = [routes objectForKey:index];
        
        if ([cachedAnnotations objectForKey:index] != nil) {
            [self displayAnnotation:[cachedAnnotations objectForKey:index] forRoute:route];
        } else {
            RMPath *path = [[RMPath alloc] initWithView:self.mapView];
            [path setLineColor:[UIColor colorWithHexString:route.color]];
            [path setFillColor:[UIColor colorWithHexString:route.color]];
            [path setLineWidth:3];
            
            // store first coordinates for annotation positioning
            double latF = zeroCoordComponent;
            double lonF = zeroCoordComponent;
            
            double lat = zeroCoordComponent;
            double lon = zeroCoordComponent;
            
            NSMutableArray *locations = [NSMutableArray array];
            for (NSDictionary *coordinates in [route coordinates]) {
                if (lat != zeroCoordComponent && lon != zeroCoordComponent) {
                    [path moveToCoordinate:CLLocationCoordinate2DMake(lat, lon)];
                }
                
                lat = [[coordinates objectForKey:@"lat"] doubleValue];
                lon = [[coordinates objectForKey:@"lon"] doubleValue];
                
                if (latF == zeroCoordComponent && lonF == zeroCoordComponent) {
                    latF = lat;
                    lonF = lon;
                }
                
                [path addLineToCoordinate:CLLocationCoordinate2DMake(lat, lon)];
                [locations addObject:[[CLLocation alloc] initWithLatitude:lat longitude:lon]];
            }
            [path closePath];
            
            RMAnnotation *annotation = [[RMAnnotation alloc]initWithMapView:self.mapView 
                                                                 coordinate:CLLocationCoordinate2DMake(latF, lonF)
                                                                   andTitle:@""];
            
            [annotation setUserInfo:path];
            [annotation setHasBoundingBox:YES];
            [annotation setBoundingBoxFromLocations:locations];
            
            [self.mapView addAnnotation:annotation];
            [cachedAnnotations setObject:annotation forKey:index];
            [self displayAnnotation:annotation forRoute:route];
        }
        

    }
}

- (void) vehicleInstantsLoad:(NSArray *)instants
{
    for (Instant* instant in instants) {
        RMAnnotation *annotation = [[RMAnnotation alloc]initWithMapView:self.mapView 
                                                             coordinate:instant.coordinates
                                                               andTitle:@""];
        annotation.anchorPoint = CGPointMake(10, 10);
        [annotation setUserInfo:[[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"bus.png"]]];
        [self.mapView addAnnotation:annotation];
    }
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation {
    return annotation.userInfo;
}

/*
 *  Finishes the loading of a map from the given SQLbased tileset source
 */
- (void) mapCustomization
{
    mapView.backgroundColor = [UIColor darkGrayColor];
    mapView.decelerationMode = RMMapDecelerationFast;
    mapView.boundingMask = RMMapMinHeightBound;
    mapView.adjustTilesForRetinaDisplay = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillDisappear:(BOOL)animated
{
}

- (void)viewWillAppear:(BOOL)animated
{
    [self routesLoad];
    [locationFetcher startUpdatingLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
