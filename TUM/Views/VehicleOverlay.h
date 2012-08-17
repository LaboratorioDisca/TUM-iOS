//
//  VehicleOverlay.h
//  TUM
//
//  Created by Alejandro on 03/08/12.
//  Copyright (c) 2012  UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationConfig.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor-Expanded.h"
#import <MapBox/MapBox.h>
#import "InstantRMMarker.h"
#import "VehicleAnnotation.h"

@interface VehicleOverlay : UIView {
    UILabel *speedLabel;
    UILabel *identifierLabel;
    UILabel *dateLabel;
    VehicleAnnotation *annotation;
}

@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *identifierLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) VehicleAnnotation *annotation;

+ (id) overlayForAnnotation:(VehicleAnnotation*) annotation;
- (void) destroy;

- (id) initWithFrame:(CGRect)frame withVehicleAnnotation:(VehicleAnnotation*)annotation_;

- (NSNumber*) associatedVehicleId;
- (CLLocationCoordinate2D) associatedVehicleCoordinate;
- (void) destroyVehicleOverlay;
- (void) wireDestroyActionTo:(id)object;
@end
