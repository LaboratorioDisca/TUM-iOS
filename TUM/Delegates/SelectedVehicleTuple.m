//
//  SelectedVehicleTuple.m
//  TUM
//
//  Created by Alejandro on 16/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "SelectedVehicleTuple.h"

@implementation SelectedVehicleTuple

@synthesize instant, route, marker, overlay;

+ (id) newWithVehicle:(Vehicle*)vehicle route:(Route*)route andCoordinate:(CLLocationCoordinate2D)coordinate
{
    return [[SelectedVehicleTuple alloc] initWithVehicle:vehicle route:route andCoordinate:coordinate];
}

- (id) initWithVehicle:(Vehicle*)vehicle_ route:(Route*)route_ andCoordinate:(CLLocationCoordinate2D)coordinate_
{
    self = [super init];
    if (self) {
        vehicle = vehicle_;
        route = route_;
        coordinate = coordinate_;
    }
    return self;
}

@end
