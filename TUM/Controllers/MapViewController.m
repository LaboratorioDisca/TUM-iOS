//
//  MapViewController.m
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () {
    NSMutableDictionary *cachedAnnotations;
    LegendOverlay *legend;
    CLLocationManager *locationFetcher;
    AVAudioPlayer *player;
    BOOL automaticInstantsFetch;
    
    VehicleOverlay* currentVehicleOverlay;
    UIViewPopover *popover;
    PlaceAnnotation *currentPlace;
    PlaceOverlay *placeOverlay;
}

@property (nonatomic, assign) BOOL automaticInstantsFetch;

- (void) drawRoutes;
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
                                       centerCoordinate:[ApplicationConfig coordinates] zoomLevel:15 maxZoomLevel:20 minZoomLevel:9
                                        backgroundImage:nil];
        
        [self.mapView setDelegate:self];
        [self.view addSubview:mapView];
        
        [self.mapView setShowsUserLocation:YES];
        //[self.mapView setUserTrackingMode:RMUserTrackingModeFollowWithHeading animated:YES];

        [self mapCustomization];

        legend = [[LegendOverlay alloc] initWithFrame:CGRectMake(35, 80, 250, 320) withImageNamed:@"legend.png"];
        [self.view addSubview:legend];
        
        [self setLeftButtonEnabled:YES];
        [self setRightButtonEnabled:YES];
        
        //[self drawStations];
        popover = [[UIViewPopover alloc] initOnRightPositionWithItems:[NSArray arrayWithObjects:@"routes", @"places", @"bookLegend", nil]];
        
        ReactiveFocusView *viewReact = [[ReactiveFocusView alloc] initWithFrame:[ApplicationConfig viewBounds]];
        [viewReact setDelegate:popover];
        [popover setDelegate:self];
        [self.view addSubview:viewReact];
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
    [self.mapView removeAnnotation:annotation];
    
    if ([route visibleOnMap]) {
        [self.mapView addAnnotation:annotation];
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
        [self drawVehiclesInstantsOnMap];
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
    }
}

/*
 * Loads the given routes into the map
 */
- (void) drawRoutes
{
    NSDictionary *routes = [[Routes currentCollection] collection];
    // index are the keys of the routes collection, the keys are id's on the corresponding backend database model
    for (NSNumber *index in [routes keyEnumerator]) {
        Route *route = [routes objectForKey:index];
        // store the cached route under a namespace
        NSString *cachedRouteId = [NSString stringWithFormat:@"R-%d", route.identifier];
        RMAnnotation *annotation = [cachedAnnotations objectForKey:cachedRouteId];
        
        // Create an annotation if none is registered for the route with index id
        if (annotation == nil) {
            RMShape *path = [[RMShape alloc] initWithView:self.mapView];
            [path setLineColor:[UIColor colorWithHexString:route.color]];
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
    
    if(currentVehicleOverlay != nil) {
        NSNumber *routeId = [[[currentVehicleOverlay annotation] route] identifier];
        RMAnnotation *annotation = [cachedAnnotations objectForKey:[NSString stringWithFormat:@"R-%d", [routeId intValue]]];
        if(annotation != nil && ![[mapView annotations] containsObject:annotation]) {
            [self destroyVehicleOverlayWithMapRelocation:YES];
        }
    }
}

- (void) tapOnAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    [legend hide];
    
    if ([annotation class] == [VehicleAnnotation class]) {
        [self destroyVehicleOverlayWithMapRelocation:NO];
        [self addOrUpdateVehicleOverlay:(VehicleAnnotation*) annotation];
        [placeOverlay hide];
    } else if([annotation class] == [PlaceAnnotation class]) {
        [self addOverlayForPlace:currentPlace.place];
    }
    
}

- (void) drawVehiclesInstantsOnMap
{
    for (Instant* instant in [[[Instants currentCollection] collection] allValues]) {
        // vehicle and route retrieval
        Route *route = [Routes fetchRouteWithId:[Vehicles routeForVehicleId:instant.vehicleId]];
        
        // cache the vehicle id under a namespace
        NSString *cachedVehicleId = [NSString stringWithFormat:@"V-%d", [instant.vehicleId intValue]];
        VehicleAnnotation *annotation = [cachedAnnotations objectForKey:cachedVehicleId];

        if (annotation == nil) {
            annotation = [[VehicleAnnotation alloc]initWithMapView:self.mapView instant:instant andRoute:route];
        } else {
            [annotation setInstant:instant];
        }
        [cachedAnnotations setObject:annotation forKey:cachedVehicleId];

        [self displayAnnotation:annotation forRoute:route];
        
    }
    
    if (currentVehicleOverlay != nil) {
        
        int vehicleId = [[[currentVehicleOverlay annotation].instant vehicleId] intValue];
        VehicleAnnotation *annotation = [cachedAnnotations objectForKey:[NSString stringWithFormat:@"V-%d", vehicleId]];
        if ([[mapView annotations] containsObject:annotation]) {
            [self addOrUpdateVehicleOverlay:annotation];
        } else {
            [self destroyVehicleOverlayWithMapRelocation:NO];
        }
    }
    
}

- (void) addOrUpdateVehicleOverlay:(VehicleAnnotation *)annotation
{
    [self destroyVehicleOverlayWithMapRelocation:NO];
    
    currentVehicleOverlay = [VehicleOverlay overlayForAnnotation:annotation];
    [currentVehicleOverlay wireDestroyActionTo:self];
    [self.view addSubview:currentVehicleOverlay];
    [self setMapToCenter:[annotation instant].coordinates withZoom:18];
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation {
    return annotation.userInfo;
}

- (void) prepareDrawables
{
    [self setAutomaticInstantsFetch:YES];
    [self updateVehiclesInstants];
    
    [self drawRoutes];
    //[locationFetcher startUpdatingLocation];
}

- (void) setMapToCenter:(CLLocationCoordinate2D)coordinate withZoom:(int)zoom
{
    [self.mapView setZoom:zoom];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

- (void) setMapToDefaultCenterWithZoom:(int)zoom
{
    [self setMapToCenter:[ApplicationConfig coordinates] withZoom:zoom];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewDeckController setPanningMode:IIViewDeckNoPanning];
    [self prepareDrawables];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self setAutomaticInstantsFetch:NO];
    [placeOverlay hide];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) onLeftControlActivate
{
    [self.viewDeckController openLeftView];
    [popover disappearAnimated:NO];
}

- (void) onRightControlActivate
{
    if ([popover superview] == NULL) {
        [self.view addSubview:popover];
        [popover appearAnimated:YES];
    } else {
        [popover disappearAnimated:YES];
    }
    
}

- (void) viewDeckControllerDidCloseRightView:(IIViewDeckController *)viewDeckController animated:(BOOL)animated {
    [self prepareDrawables];
}

- (void) reactToPopoverItemSelectedWith:(int)number
{
    // routes
    if (number == 1) {
        self.viewDeckController.rightController = [RoutesViewController controller];
        [self.viewDeckController toggleRightViewAnimated:YES];
    } else if (number == 2) {
        PlacesSearchViewController *searchViewController = [[PlacesSearchViewController alloc] init];
        [searchViewController setDelegate:self];
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:searchViewController];
        [self presentModalViewController:navigation animated:YES];
    } else if (number == 3) {
        [self toogleLegendVisibility];
    }
}

- (void) clearViewForPopover
{
    [legend hide];
    [self destroyVehicleOverlayWithMapRelocation:NO];
}

- (void) setPlaceOnMap:(Place *)place
{
    if (currentPlace != NULL) {
        [self.mapView removeAnnotation:currentPlace];
    }
    
    [self destroyVehicleOverlayWithMapRelocation:NO];
    [self setMapToCenter:place.coordinate withZoom:18];
    
    currentPlace = [[PlaceAnnotation alloc] initWithMapView:self.mapView andPlace:place];
    [self.mapView addAnnotation:currentPlace];
}

/* Overlays hidders */

- (void) destroyVehicleOverlay
{
    [self destroyVehicleOverlayWithMapRelocation:YES];
}

- (void) destroyVehicleOverlayWithMapRelocation:(BOOL)relocate
{
    if (currentVehicleOverlay != NULL) {
        [currentVehicleOverlay destroy];
        currentVehicleOverlay = NULL;
        if (relocate) {
            [self setMapToDefaultCenterWithZoom:16];
        }
    }
}

- (void) toogleLegendVisibility
{
    if ([legend isHidden]) {
        [popover disappearAnimated:NO];
        [self destroyVehicleOverlayWithMapRelocation:NO];
        [legend show];
    } else {
        [legend hide];
    }
}

- (void) addOverlayForPlace:(Place *)place 
{
    [placeOverlay hide];   
    placeOverlay = [[PlaceOverlay alloc] initWithPlace:place];
    [self.view addSubview:placeOverlay];
}

@end
