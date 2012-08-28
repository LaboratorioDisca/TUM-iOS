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
#import "Instant.h"
#import "Vehicles.h"

#import "SBJson.h"
#import "Instants.h"
#import "LegendOverlay.h"
#import "Vehicle.h"
#import "VehicleOverlay.h"

#import "SelectedVehicleTuple.h"
#import "Places.h"
#import "UIViewPopover.h"
#import "ReactiveFocusView.h"
#import "PopoverFocusDelegate.h"
#import "PopoverActionMenuItemDelegate.h"

#import "PlacesSearchViewController.h"
#import "PlaceOnMapDelegate.h"
#import "PlaceAnnotation.h"
#import "PlaceOverlay.h"

#define zeroCoordComponent -1.0f

@interface MapViewController : TabBarViewController<RMMapViewDelegate, CLLocationManagerDelegate, ASIHTTPRequestDelegate, PopoverActionMenuItemDelegate, PlaceOnMapDelegate>

@property (strong, nonatomic) RMMapView *mapView;
- (void) fetchVehicles;
- (void) drawVehiclesInstantsOnMap;
- (void) prepareDrawables;
- (void) addOrUpdateVehicleOverlay:(VehicleAnnotation*)annotation;
- (void) setMapToCenter:(CLLocationCoordinate2D)coordinate withZoom:(int)zoom;
- (void) setMapToDefaultCenterWithZoom:(int)zoom;
- (void) destroyVehicleOverlayWithMapRelocation:(BOOL)relocate;
- (void) destroyVehicleOverlay;

- (void) toogleLegendVisibility;
- (void) addOverlayForPlace:(Place*)place;
@end
