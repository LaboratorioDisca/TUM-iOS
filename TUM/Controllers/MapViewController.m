//
//  MapViewController.m
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "MapViewController.h"
#import "RMMBTilesTileSource.h"
#import "RMMarker.h"
#import "RMMarkerManager.h"
#import "Routes.h"
#import "RMPath.h"
#import "Route.h"

@interface MapViewController ()

@end


@implementation MapViewController

@synthesize mapView;

- (id) init
{
    if((self = [super init])) {
        self.mapView = [[RMMapView alloc] initWithFrame:[ApplicationConfig viewBounds]];
        [self.view addSubview:mapView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self mapLoad];
    [self routesLoad];
}


- (void) routesLoad
{
    NSDictionary *dictionary = [Routes collection];
    
    
    for (NSNumber *index in [dictionary keyEnumerator]) {
        RMPath *path = [[RMPath alloc] initForMap:self.mapView];
        Route *route = [dictionary objectForKey:index];
        [path setLineColor:nil];
        [path setFillColor:nil];
        [path setLineWidth:1];
        
        
        //RMAnnotation *anotation = [RMAnnotation annotationWithMapView:self.mapView coordinate:nil andTitle:@""];
        //[anotation setLayer:path];
    }
    
}

/*
 *  Finishes the loading of a map from the given SQLbased tileset source
 */
- (void) mapLoad
{
    CLLocationCoordinate2D center;
	center.latitude = [ApplicationConfig coordinates].x;
	center.longitude = [ApplicationConfig coordinates].y;
    
    
    NSURL *tilesURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"UNAMCU" 
                                                                             ofType:@"mbtiles"]];
    
    RMMBTilesTileSource *source = [[RMMBTilesTileSource alloc] initWithTileSetURL:tilesURL];
    
	mapView.contents = [[RMMapContents alloc] initWithView:self.mapView 
                                                       tilesource:source
                                                     centerLatLon:center
                                                        zoomLevel:kZOOM
                                                     maxZoomLevel:[source maxZoom]
                                                     minZoomLevel:[source minZoom]
                                                  backgroundImage:nil screenScale:0];
    
    mapView.enableRotate = NO;
    mapView.deceleration = NO;
    
    mapView.backgroundColor = [UIColor blackColor];
    
    mapView.contents.zoom = kZOOM;
    [self.mapView moveToLatLong:center];
    
    UIImage *bus = [UIImage imageNamed:@"bus.png"];
    RMMarker *marker = [[RMMarker alloc] initWithUIImage:bus];
    [mapView.contents.markerManager addMarker:marker AtLatLong:center];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
