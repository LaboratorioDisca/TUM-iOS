//
//  MapViewController.h
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"
#import "ApplicationConfig.h"
#import "RMMapViewDelegate.h"
#import "UIColor-Expanded.h"

#define zeroCoordComponent -1.0f

@interface MapViewController : UIViewController<RMMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) RMMapView *mapView;
@end
