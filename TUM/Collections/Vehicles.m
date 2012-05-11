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
@synthesize collection;

+ (void) loadWithVehiclesCollection:(NSArray *)newCollection
{
    singleton = [[Vehicles alloc] initWithVehiclesCollection:newCollection];
}

+ (NSArray*) vehiclesForLine:(NSNumber *)lineId
{
    return [[singleton collection] objectForKey:lineId];
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
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSDictionary *vehicleData in collection_) {
        NSNumber* lineId = [NSNumber numberWithInt:[[vehicleData objectForKey:@"lineId"] intValue]];

        Vehicle * vehicle = [[Vehicle alloc] initWithUniqueIdentifier:[vehicleData objectForKey:@"identifier"] 
                                                       withIdentifier:[NSNumber numberWithInt:[[vehicleData objectForKey:@"id"] intValue]]  
                                                           withLineId:lineId];
        
        if ([dictionary objectForKey:lineId] == nil) {
            [dictionary setObject:[NSMutableArray array] forKey:lineId];
        } 
        
        NSMutableArray * vehicles = [dictionary objectForKey:lineId];
        [vehicles addObject:vehicle];
    }

    [self setCollection:dictionary];
}


@end
