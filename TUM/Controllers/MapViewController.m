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


@interface MapViewController () {
    NSMutableArray *cachedPaths;
}
- (void) mapCustomization;
@end


@implementation MapViewController

@synthesize mapView;

- (id) init
{
    if((self = [super init])) {
        cachedPaths = [NSMutableArray array];
        
        NSURL *tilesURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"UNAMCU" 
                                                                                 ofType:@"mbtiles"]];
        RMMBTilesSource *offlineSource = [[RMMBTilesSource alloc] initWithTileSetURL:tilesURL];

        CLLocationCoordinate2D center;
        center.latitude = [ApplicationConfig coordinates].x;
        center.longitude = [ApplicationConfig coordinates].y;
        
        self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds 
                                          andTilesource:offlineSource 
                                       centerCoordinate:center zoomLevel:16 maxZoomLevel:20 minZoomLevel:9 backgroundImage:nil];
        [self.mapView setDelegate:self];
        [self.view addSubview:mapView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self mapCustomization];
}


/*
 * Loads the given routes into the map
 */
- (void) routesLoad
{
    NSDictionary *routes = [[Routes currentCollection] collection];
    for (NSNumber *index in [routes keyEnumerator]) {
        RMPath *path = [[RMPath alloc] initWithView:self.mapView];
        Route *route = [routes objectForKey:index];
        [path setLineColor:[UIColor colorWithHexString:route.color]];
        [path setFillColor:[UIColor colorWithHexString:route.color]];
        [path setLineWidth:2];
            
        // store first coordinates for annotation positioning
        double latF = zeroCoordComponent;
        double lonF = zeroCoordComponent;
        
        double lat = zeroCoordComponent;
        double lon = zeroCoordComponent;
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
        }
        [path closePath];

        RMAnnotation *annotation = [[RMAnnotation alloc]initWithMapView:self.mapView 
                                                             coordinate:CLLocationCoordinate2DMake(latF, lonF)
                                                               andTitle:@""];

        annotation.anchorPoint = CGPointMake(0.5, 1.0);
        [cachedPaths addObject:path];
        [annotation setUserInfo:[NSNumber numberWithInt:[cachedPaths indexOfObject:path]]];
        
        [self.mapView addAnnotation:annotation];        
    }
    

}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation {
    [annotation setLayer:[cachedPaths objectAtIndex:[[annotation userInfo] intValue]]];
    return annotation.layer;
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
