//
//  MapViewController.h
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapBox/MapBox.h>
#import <AVFoundation/AVFoundation.h>

#import "TabBarViewController.h"
#import "IIViewDeckController.h"
#import "RoutesViewController.h"

#import "ApplicationConfig.h"
#import "UIColor-Expanded.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequest.h"

#import "VehicleOverlay.h"
#import "VehicleAnnotation.h"

#import "Routes.h"
#import "Route.h"
#import "OvermapButton.h"
#import "Instant.h"
#import "Vehicles.h"
#import "InstantRMMarker.h"

#import "SBJson.h"
#import "Instants.h"
#import "OverlayLegend.h"
#import "Vehicle.h"
#import "VehicleOverlay.h"

#import "SelectedVehicleTuple.h"

#define zeroCoordComponent -1.0f

@interface MapViewController : TabBarViewController<RMMapViewDelegate, CLLocationManagerDelegate, ASIHTTPRequestDelegate>

@property (strong, nonatomic) RMMapView *mapView;

- (void) fetchVehicles;
- (void) drawVehiclesInstantsOnMap;
- (void) instructionsDisplay;
- (void) prepareDrawables;
- (void) addOrUpdateVehicleOverlay:(RMAnnotation*)annotation;
@end
