//
//  Instants.m
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Instants.h"
#import "Instant.h"

static Instants *singleton;

@implementation Instants
@synthesize collection, receiverDelegate;


+ (void) initializeWithDelegate:(id<InstantsReceiverDelegate>)delegate
{
    if (singleton == NULL) {
        singleton = [[Instants alloc] init];
    }
    [singleton setReceiverDelegate:delegate];
}

+ (void) loadWithInstantsCollection:(NSArray *)collection_
{
    [singleton updateCollectionWithCollection:collection_];
}

+ (id) currentCollection
{
    return singleton;
}

- (id) init
{
    if ((self=[super init])) {
        self.collection = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) updateCollectionWithCollection:(NSArray *)collection_
{
    for (NSDictionary *instantData in collection_) {
        NSNumber *vehicleId = [NSNumber numberWithInt:[[instantData objectForKey:@"vehicleId"] intValue]];
        
        Instant *instant = [[Instant alloc] initWithCoordinates:[instantData objectForKey:@"coordinate"] 
                                                  withVehicleId:vehicleId
                                               withVehicleSpeed:[instantData objectForKey:@"speed"] 
                                               withMilliseconds:[[instantData objectForKey:@"createdAt"] doubleValue]];
        
        [self.collection setObject:instant forKey:vehicleId];

    }
    [[self receiverDelegate] vehicleInstantsLoad:[self.collection allValues]];
}



@end
