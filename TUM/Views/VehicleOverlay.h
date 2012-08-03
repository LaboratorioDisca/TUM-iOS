//
//  VehicleOverlay.h
//  TUM
//
//  Created by Alejandro on 03/08/12.
//  Copyright (c) 2012  UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationConfig.h"

@interface VehicleOverlay : UIView {
    UILabel *speedLabel;
    UILabel *identifierLabel;
    UILabel *dateLabel;
}

@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *identifierLabel;
@property (nonatomic, strong) UILabel *dateLabel;

+ (void) overlayWithVehicleId:(NSString*)identifier withSpeed:(NSNumber*)speed withDate :(NSDate*)date forView:(UIView *)view;
- (void) fadeIn;
- (void) fadeOut;
@end
