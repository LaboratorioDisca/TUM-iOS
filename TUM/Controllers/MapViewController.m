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
    ReactiveFocusView *viewReact;
    
    VehicleOverlay* currentVehicleOverlay;
    UIViewPopover *popover;
    PlaceAnnotation *currentPlace;
    PlaceOverlay *placeOverlay;    
}

@property (nonatomic, assign) BOOL automaticInstantsFetch;

- (void) mapCustomization;
- (void) displayAnnotation:(RMAnnotation*)annotation forRoute:(Route*)route;
- (void) updateVehiclesInstants;
- (void) animateLocationUpdating;

@end


@implementation MapViewController

@synthesize mapView, automaticInstantsFetch;

- (id) initWithTileSource:(RMMBTilesSource *)tileSource
{
    if((self = [super init])) {
        automaticInstantsFetch = NO;
        [self fetchVehicles];
        
        // annotations cache
        cachedAnnotations = [NSMutableDictionary dictionary];

        // retrieve a new location
        locationFetcher = [[CLLocationManager alloc] init];
        [locationFetcher setDelegate:self];
        [locationFetcher setDesiredAccuracy:kCLLocationAccuracyBest];
        
        
        self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds 
                                          andTilesource:tileSource 
                                       centerCoordinate:[ApplicationConfig coordinates] 
                                              zoomLevel:kInitialZoom 
                                           maxZoomLevel:20 
                                           minZoomLevel:9
                                        backgroundImage:nil];
        
        [AnnotationsGroups startWithMap:self.mapView];
        
        [self.mapView setDelegate:self];
        [self.mapView setShowsUserLocation:YES];

        [self mapCustomization];

        [self.view addSubview:mapView];

        legend = [[LegendOverlay alloc] initWithFrame:CGRectMake(35, 80, 250, 320) withImageNamed:@"legend.png"];
        [self.view addSubview:legend];
        
        [self setLeftButtonEnabled:YES];
        [self setRightButtonEnabled:YES];
        [self setSecondRightButtonEnabled:YES];
        
        popover = [[UIViewPopover alloc] initOnRightPositionWithItems:[NSArray arrayWithObjects:@"routes", @"places", @"bookLegend", nil]];
        
        viewReact = [[ReactiveFocusView alloc] initWithFrame:[ApplicationConfig viewBounds]];
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
    [rightButton.layer performSelector:@selector(removeAllAnimations) withObject:nil afterDelay:1.5f];
}

/*
 * Decides wether an annotation should be displayed or not
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

- (void)requestFailed:(ASIHTTPRequest *)request { }

/* End requests section */

- (void) updateVehiclesInstants
{
    [self fetchInstants];
    if ([self automaticInstantsFetch]) {
        [self performSelector:@selector(updateVehiclesInstants) withObject:nil afterDelay:kInstantsUpdateOverhead];
        NSLog(@"Just reloaded vehicle positions");
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
    [self setMapToCenter:[annotation instant].coordinates withZoom:kDefaultZoom];
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation {
    return annotation.userInfo;
}


- (void) prepareDrawables
{
    [self setAutomaticInstantsFetch:YES];
    [self updateVehiclesInstants];
}

#pragma Map positioning methods
/* Begins map positioning methods */

- (void) setMapToCenter:(CLLocationCoordinate2D)coordinate withZoom:(int)zoom
{
    [self.mapView setZoom:zoom];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

- (void) setMapToDefaultCenterWithZoom:(int)zoom
{
    [self setMapToCenter:[ApplicationConfig coordinates] withZoom:zoom];
}

/* Ends map positioning methods */

#pragma View management default methods
/* Begins View management default methods */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self prepareDrawables];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewDeckController setRightController:nil];
    [self.viewDeckController setPanningMode:IIViewDeckPanningViewPanning];
    [self.viewDeckController setPanningView:navigationBar];
    
    [rightButton addTarget:self action:@selector(animateLocationUpdating) forControlEvents:UIControlEventTouchUpInside];
}

- (void) animateLocationUpdating
{
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOutAnimation.duration = 1.0f;
    fadeOutAnimation.removedOnCompletion = NO;
    fadeOutAnimation.fillMode = kCAFillModeForwards;
    fadeOutAnimation.toValue = [NSNumber numberWithFloat:0.3f];
    fadeOutAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    fadeOutAnimation.autoreverses = YES;
    fadeOutAnimation.repeatCount = 100;
    [rightButton.layer addAnimation:fadeOutAnimation forKey:@"animateOpacity"];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self setAutomaticInstantsFetch:NO];
    //[placeOverlay hide];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* Ends view default methods */

#pragma NavigationBar buttons actions
/* Begins NavigationBar buttons actions */

- (void) onLeftControlActivate
{
    [self.viewDeckController openLeftView];
    [popover disappearAnimated:NO];
}

- (void) onRightControlActivate
{
    [locationFetcher startUpdatingLocation];
}

- (void) onSecondRightControlActivate
{
    if ([popover superview] == NULL) {
        [self.view addSubview:popover];
        [popover appearAnimated:YES];
    } else {
        [popover disappearAnimated:YES];
    }
}

/* Ends NavigationBar buttons actions */

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

- (void) setPlaceOnMap:(Place *)place
{
    if (currentPlace != NULL) {
        [self.mapView removeAnnotation:currentPlace];
    }
    
    [self destroyVehicleOverlayWithMapRelocation:NO];
    [self setMapToCenter:place.coordinate withZoom:18];
    
    currentPlace = [[PlaceAnnotation alloc] initWithMapView:self.mapView andPlace:place];
    [self.mapView addAnnotation:currentPlace];
    
    [self addOverlayForPlace:place];
}

#pragma Overlays hidders
/* Begins Overlays hidders */

- (void) clearViewForPopover
{
    [legend hide];
    [self destroyVehicleOverlayWithMapRelocation:NO];
}

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
    [placeOverlay removeFromSuperview];   
    placeOverlay = [[PlaceOverlay alloc] initWithPlace:place];
    [self.view addSubview:placeOverlay];
    [self setMapToCenter:place.coordinate withZoom:kDefaultZoom];
}

/* Ends Overlays hidders */

@end
