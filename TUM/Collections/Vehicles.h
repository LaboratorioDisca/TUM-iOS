//
//  Vehicles.h
//  TUM
//
//  Created by Alejandro on 5/8/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicles : NSObject {
    NSDictionary *linesVehicles;
}

@property (nonatomic, strong) NSDictionary *linesVehicles;
@property (nonatomic, strong) NSDictionary *vehicleLines;

+ (void) loadWithVehiclesCollection:(NSArray*)collection;
+ (NSArray*) vehiclesForLine:(NSNumber*)lineId;
+ (NSNumber*) routeForVehicleId:(NSNumber*)identifier;

+ (Vehicles*) all;

- (id) initWithVehiclesCollection:(NSArray*)collection;

@end
