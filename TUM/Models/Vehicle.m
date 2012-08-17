//
//  Vehicle.m
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle
@synthesize identifier, number, lineId, vehicleNumber;

- (id) initWithNumber:(NSString *)number_ withIdentifier:(NSNumber *)identifier_ withLineId:(NSNumber *)lineId_ withVehicleNumber:(NSString *)vehicleNumber_
{
    self = [self init];
    if (self) {
        [self setLineId:lineId_];
        [self setIdentifier:identifier_];
        [self setNumber:number_];
        [self setVehicleNumber:vehicleNumber_];
    }
    return self;
}

@end
