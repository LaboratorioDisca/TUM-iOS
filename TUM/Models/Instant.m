//
//  Instant.m
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Instant.h"

@implementation Instant
@synthesize coordinates, date, vehicleId, vehicleSpeed;

- (id) initWithCoordinates:(NSDictionary *)coordinates_ 
             withVehicleId:(NSNumber *)vehicleId_ 
          withVehicleSpeed:(NSNumber *)speed_ 
          withMilliseconds:(double) milliseconds {
    self = [self init];
    
    if (self) {
        [self setVehicleId:vehicleId_];
        [self setVehicleSpeed:speed_];
        self.coordinates = CLLocationCoordinate2DMake([[coordinates_ objectForKey:@"lat"] floatValue], 
                                                      [[coordinates_ objectForKey:@"lon"] floatValue]);
        [self setDate:[NSDate dateWithTimeIntervalSince1970:milliseconds*0.001]];
    }
    return self;
}


@end
