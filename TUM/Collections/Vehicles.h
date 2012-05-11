//
//  Vehicles.h
//  TUM
//
//  Created by Alejandro on 5/8/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicles : NSObject {
    NSDictionary *collection;
}

@property (nonatomic, strong) NSDictionary *collection;

+ (void) loadWithVehiclesCollection:(NSArray*)collection;
+ (NSArray*) vehiclesForLine:(NSNumber*)lineId;

- (id) initWithVehiclesCollection:(NSArray*)collection;

@end
