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

@interface VehicleOverlay : UIView {
    UILabel *speedLabel;
    UILabel *identifierLabel;
    UILabel *dateLabel;
    RMAnnotation *annotation;
}

@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *identifierLabel;
@property (nonatomic, strong) UILabel *dateLabel;

+ (void) overlayWithAnnotation:(InstantRMMarker*) annotation forView:(UIView *)view;
+ (VehicleOverlay*) current;
+ (void) destroy;

- (void) fadeIn;
- (void) fadeOut;
@end
