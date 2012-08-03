//
//  MapViewController.h
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapBox/MapBox.h>
#import "ApplicationConfig.h"
#import "UIColor-Expanded.h"
#import "ASIHTTPRequestDelegate.h"
#import "VehicleOverlay.h"

#define zeroCoordComponent -1.0f

@interface MapViewController : UIViewController<RMMapViewDelegate, CLLocationManagerDelegate, ASIHTTPRequestDelegate>

@property (strong, nonatomic) RMMapView *mapView;

- (void) fetchVehicles;
- (void) drawVehiclesInstantsOnMap;
- (void) instructionsDisplay;
@end
