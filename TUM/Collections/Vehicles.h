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
    NSDictionary *vehicles;
    NSDictionary *vehicleLines;
}

@property (nonatomic, readonly) NSDictionary *vehicleLines;
@property (nonatomic, readonly) NSDictionary *vehicles;

+ (void) loadWithVehiclesCollection:(NSArray*)collection;
+ (void) prepareForCollection;
+ (NSNumber*) routeForVehicleId:(NSNumber*)identifier;
+ (Vehicle*) getVehicleById:(NSNumber*)vehicleId;
+ (Vehicles*) all;

+ (BOOL) haveBeenSynchronized;

- (id) initWithVehiclesCollection:(NSArray*)collection;
@end
