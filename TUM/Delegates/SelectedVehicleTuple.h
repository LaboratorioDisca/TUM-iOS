//
//  SelectedVehicleTuple.h
//  TUM
//
//  Created by Alejandro on 16/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instant.h"
#import "Route.h"
#import "VehicleOverlay.h"
#import "Vehicle.h"

@interface SelectedVehicleTuple : NSObject {
    Vehicle *vehicle;
    Route *route;
    CLLocationCoordinate2D coordinate;
    
    VehicleOverlay *overlay;
}

@property (readonly, nonatomic) Instant *instant;
@property (readonly, nonatomic) Route *route;
@property (readonly, nonatomic) VehicleOverlay *overlay;

+ (id) newWithVehicle:(Vehicle*)vehicle route:(Route*)route andCoordinate:(CLLocationCoordinate2D)coordinate;
- (id) initWithVehicle:(Vehicle*)vehicle route:(Route*)route andCoordinate:(CLLocationCoordinate2D)coordinate;
@end
