//
//  InstantRMMarker.m
//  TUM
//
//  Created by Alejandro on 5/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "InstantRMMarker.h"

@implementation InstantRMMarker

@synthesize instant, vehicleNumber, routeColor;

- (void) setInstant:(Instant *)instant_ color:(NSString*)color_ andVehicleNumber:(NSString*)vehicleNumber_
{
    [self setInstant:instant_];
    [self setRouteColor:color_];
    [self setVehicleNumber:vehicleNumber_];
}
@end
