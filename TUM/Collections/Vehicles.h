//
//  Vehicles.h
//  TUM
//
//  Created by Alejandro on 5/8/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

@interface Vehicles : NSObject {
    NSDictionary *linesVehicles;
    NSDictionary *vehicles;
}

@property (nonatomic, readonly) NSDictionary *linesVehicles;
@property (nonatomic, readonly) NSDictionary *vehicleLines;
@property (nonatomic, readonly) NSDictionary *vehicles;

+ (void) loadWithVehiclesCollection:(NSArray*)collection;
+ (NSArray*) vehiclesForLine:(NSNumber*)lineId;
+ (NSNumber*) routeForVehicleId:(NSNumber*)identifier;
+ (Vehicle*) getVehicleById:(NSNumber*)vehicleId;
+ (Vehicles*) all;

- (id) initWithVehiclesCollection:(NSArray*)collection;

@end
