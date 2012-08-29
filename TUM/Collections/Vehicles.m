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
@synthesize vehicleLines, vehicles;

+ (void) loadWithVehiclesCollection:(NSArray *)newCollection
{
    singleton = [[Vehicles alloc] initWithVehiclesCollection:newCollection];
}

+ (NSNumber*) routeForVehicleId:(NSNumber *)identifier
{
    return [[singleton vehicleLines] objectForKey:identifier];
}

+ (Vehicle*) getVehicleById:(NSNumber *)vehicleId
{
    return [[singleton vehicles] objectForKey:vehicleId];
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
    NSMutableDictionary *dictionaryForVehicles = [NSMutableDictionary dictionary];

    for (NSDictionary *vehicleData in collection_) {
        NSNumber* lineId = [NSNumber numberWithInt:[[vehicleData objectForKey:@"lineId"] intValue]];
        NSNumber *identifier = [NSNumber numberWithInt:[[vehicleData objectForKey:@"id"] intValue]];

        NSString *publicNumber = [[vehicleData objectForKey:@"publicNumber"] stringValue];
        if ([publicNumber intValue] < 0) {
            publicNumber = @"S/N";
        }
        
        Vehicle * vehicle = [[Vehicle alloc] initWithNumber:[vehicleData objectForKey:@"identifier"]
                                             withIdentifier:identifier  
                                                 withLineId:lineId
                                          withVehicleNumber:publicNumber];
        
        // *** For quick lookup:
        // Insert in lines-vehicles dictionary
        if ([dictionaryForLinesVehicles objectForKey:lineId] == nil) {
            [dictionaryForLinesVehicles setObject:[NSMutableArray array] forKey:lineId];
        } 
        
        [[dictionaryForLinesVehicles objectForKey:lineId] addObject:vehicle];
        
        // Insert in vehicle-line dictionary
        [dictionaryForVehicleLine setObject:lineId forKey:identifier];
        [dictionaryForVehicles setObject:vehicle forKey:identifier];
    }

    vehicleLines = dictionaryForVehicleLine;
    vehicles = dictionaryForVehicles;
    
}


@end
