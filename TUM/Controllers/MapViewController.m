//
//  MapViewController.m
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "MapViewController.h"
#import <MapBox/MapBox.h>
#import "Routes.h"
#import "Route.h"
#import "ApplicationConfig.h"
#import "OvermapButton.h"
#import <AVFoundation/AVFoundation.h>

#import "Instant.h"
#import "Vehicles.h"
#import "Routes.h"
#import "InstantRMMarker.h"

#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "Instants.h"
#import "OverlayLegend.h"

@interface MapViewController () {
    NSMutableDictionary *cachedAnnotations;
    OvermapButton *mapInstructions;
    OverlayLegend *legend;
    CLLocationManager *locationFetcher;
    AVAudioPlayer *player;
    BOOL automaticInstantsFetch;
}

@property (nonatomic, assign) BOOL automaticInstantsFetch;

- (void) drawRoutesOnMap;
- (void) mapCustomization;
- (void) displayAnnotation:(RMAnnotation*)annotation forRoute:(Route*)route;
- (void) updateVehiclesInstants;
@end


@implementation MapViewController

@synthesize mapView, automaticInstantsFetch;

- (id) init
{
    if((self = [super init])) {
        automaticInstantsFetch = YES;
        [self fetchVehicles];
        
        // annotations cache
        cachedAnnotations = [NSMutableDictionary dictionary];

        // retrieve a new location
        locationFetcher = [[CLLocationManager alloc] init];
        [locationFetcher setDelegate:self];
        [locationFetcher setDesiredAccuracy:kCLLocationAccuracyBest];
                
                
        // load tiles from SQLlite db
        NSURL *tilesURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"UNAMCU" 
                                                                                 ofType:@"mbtiles"]];
        RMMBTilesSource *offlineSource = [[RMMBTilesSource alloc] initWithTileSetURL:tilesURL];
        
        self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds 
                                          andTilesource:offlineSource 
                                       centerCoordinate:[ApplicationConfig coordinates] zoomLevel:18 maxZoomLevel:20 minZoomLevel:9
                                        backgroundImage:nil];
        
        [self.mapView setDelegate:self];
        [self.view addSubview:mapView];
        
        [self mapCustomization];

        mapInstructions = [[OvermapButton alloc] initWithImageNamed:@"grid.png"];
        [self.view addSubview:mapInstructions];
        [mapInstructions addTarget:self action:@selector(instructionsDisplay) forControlEvents:UIControlEventTouchUpInside];
        legend = [[OverlayLegend alloc] initWithFrame:CGRectMake(35, 45, 250, 320) withImageNamed:@"legend.png"];
        [self.view addSubview:legend];
        [legend setDelegate:mapInstructions];

    }
    return self;
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

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.mapView setCenterCoordinate:[newLocation coordinate] animated:YES];
    [locationFetcher stopUpdatingLocation];
}

/*
 * Decides if an annotation should be displayed or not
 */
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

/* Start requests section */

- (void) fetchInstants
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[ApplicationConfig urlForResource:@"instants"]]];
    [request setTag:1];
    [request setDelegate:self];
    [request startAsynchronous];
} 

- (void) fetchVehicles
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[ApplicationConfig urlForResource:@"vehicles"]]];
    [request setTag:2];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Insert the recently loaded data from Backend
    if ([request tag] == 1) {
        [Instants loadWithInstantsCollection:[[request responseString] JSONValue]];
    } else if ([request tag] == 2) {
        [Vehicles loadWithVehiclesCollection:[[request responseString] JSONValue]];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    // Retrieve from local storage (TODO)
    //NSError *error = [request error];
}

/* End requests section */

- (void) updateVehiclesInstants
{
    [self fetchInstants];
    if ([self automaticInstantsFetch]) {
        [self performSelector:@selector(updateVehiclesInstants) withObject:nil afterDelay:10];
        NSLog(@"Just reloaded vehicle positions");
        [self drawVehiclesInstantsOnMap];
    }
}

/*
 * Loads the given routes into the map
 */
- (void) drawRoutesOnMap
{
    NSDictionary *routes = [[Routes currentCollection] collection];
    // index are the keys of the routes collection, the keys are id's on the corresponding backend database model
    for (NSNumber *index in [routes keyEnumerator]) {
        Route *route = [routes objectForKey:index];
        // store the cached route under a namespace
        NSString *cachedRouteId = [NSString stringWithFormat:@"Route-%d", index];
        RMAnnotation *annotation = [cachedAnnotations objectForKey:cachedRouteId];
        
        // Create an annotation if none is registered for the route with index id
        if (annotation == nil) {
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
            
            annotation = [[RMAnnotation alloc]initWithMapView:self.mapView 
                                                                 coordinate:CLLocationCoordinate2DMake(latF, lonF)
                                                                   andTitle:@""];
            [annotation setUserInfo:path];
            [annotation setHasBoundingBox:YES];
            [annotation setBoundingBoxFromLocations:locations];
                        
            [cachedAnnotations setObject:annotation forKey:cachedRouteId];
        }
        
        [self displayAnnotation:annotation forRoute:route];
    }
}

- (void) tapOnAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    if ([[annotation userInfo] class] == [InstantRMMarker class]) {
        //Instant* storedInstant = [annotation.userInfo instant];
        //NSLog([NSString stringWithFormat:@"Velocidad: %f y hora %@", [[storedInstant vehicleSpeed] floatValue], [storedInstant date]]);
    }
}

- (void) drawVehiclesInstantsOnMap
{
    for (Instant* instant in [[[Instants currentCollection] collection] allValues]) {
        // vehicle retrieval
        NSNumber *vehicleId = [Vehicles routeForVehicleId:instant.vehicleId];
        // route lookup
        Route *route = [Routes fetchRouteWithId:vehicleId];
        // cache the vehicle id under a namespace
        NSString *cachedVehicleId = [NSString stringWithFormat:@"Vehicle-%d", vehicleId];
        RMAnnotation *annotation = [cachedAnnotations objectForKey:cachedVehicleId];
        
        if (annotation == nil) {
            annotation = [[RMAnnotation alloc]initWithMapView:self.mapView 
                                                   coordinate:instant.coordinates
                                                     andTitle:@""];
            annotation.anchorPoint = CGPointMake(10, 10);
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", route.simpleIdentifier]];
            InstantRMMarker *marker = [[InstantRMMarker alloc] initWithUIImage:image anchorPoint:CGPointMake(0.5, 1)];
            [annotation setUserInfo:marker];
            [cachedAnnotations setObject:annotation forKey:cachedVehicleId];

        } else {
            [annotation setCoordinate:instant.coordinates];
        }
        
        [[annotation userInfo] setInstant:instant];
        [self displayAnnotation:annotation forRoute:route];
    }
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation {
    return annotation.userInfo;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setAutomaticInstantsFetch:YES];
    [self updateVehiclesInstants];

    [self drawRoutesOnMap];
    [self drawVehiclesInstantsOnMap];
    [self updateVehiclesInstants];
    [locationFetcher startUpdatingLocation];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self setAutomaticInstantsFetch:NO];
}
     
- (void) instructionsDisplay
{
    [legend show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
