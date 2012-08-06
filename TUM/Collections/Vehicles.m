//
//  Vehicles.m
//  TUM
//
//  Created by Alejandro on 5/8/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Vehicles.h"
#import "Vehicle.h"
static Vehicles *singleton;

@interface Vehicles() {
    
}

- (void) applyCollection:(NSArray*)collection_;

@end

@implementation Vehicles
@synthesize linesVehicles, vehicleLines;

+ (void) loadWithVehiclesCollection:(NSArray *)newCollection
{
    singleton = [[Vehicles alloc] initWithVehiclesCollection:newCollection];
}

+ (NSArray*) vehiclesForLine:(NSNumber *)lineId
{
    return [[singleton linesVehicles] objectForKey:lineId];
}

+ (NSNumber*) routeForVehicleId:(NSNumber *)identifier
{
    return [[singleton vehicleLines] objectForKey:identifier];
}

+ (Vehicles*) all
{
    return singleton;
}

- (id) initWithVehiclesCollection:(NSArray *)collection_
{
    self = [self init];
    if (self) {
        [self applyCollection:collection_];
    }
    return self;
}

- (void) applyCollection:(NSArray*)collection_ {
    NSMutableDictionary *dictionaryForLinesVehicles = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionaryForVehicleLine = [NSMutableDictionary dictionary];

    for (NSDictionary *vehicleData in collection_) {
        NSNumber* lineId = [NSNumber numberWithInt:[[vehicleData objectForKey:@"lineId"] intValue]];
        NSNumber *identifier = [NSNumber numberWithInt:[[vehicleData objectForKey:@"id"] intValue]];
        
        Vehicle * vehicle = [[Vehicle alloc] initWithNumber:[vehicleData objectForKey:@"identifier"]
                                             withIdentifier:identifier  
                                                 withLineId:lineId];
        
        // *** For quick lookup:
        // Insert in lines-vehicles dictionary
        if ([dictionaryForLinesVehicles objectForKey:lineId] == nil) {
            [dictionaryForLinesVehicles setObject:[NSMutableArray array] forKey:lineId];
        } 
        
        [[dictionaryForLinesVehicles objectForKey:lineId] addObject:vehicle];
        
        // Insert in vehicle-line dictionary
        [dictionaryForVehicleLine setObject:lineId forKey:identifier];

    }

    [self setLinesVehicles:dictionaryForLinesVehicles];
    [self setVehicleLines:dictionaryForVehicleLine];
}


@end
