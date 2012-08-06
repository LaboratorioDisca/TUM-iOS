//
//  InstantRMMarker.h
//  TUM
//
//  Created by Alejandro on 5/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapBox/MapBox.h>
#import "Instant.h"

@interface InstantRMMarker : RMMarker {
    Instant *instant; 
    NSString *routeColor;
    NSString *vehicleNumber;
}

@property (nonatomic, strong) Instant* instant;
@property (nonatomic, strong) NSString *routeColor;
@property (nonatomic, strong) NSString *vehicleNumber;

- (void) setInstant:(Instant *)instant color:(NSString*)color andVehicleNumber:(NSString*)vehicleNumber;

@end
