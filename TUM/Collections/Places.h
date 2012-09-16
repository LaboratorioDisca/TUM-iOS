//
//  Places.h
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface Places : NSObject {
    NSArray *collection;
}

@property (nonatomic, strong) NSArray *collection;

+ (id) loadAllPlaces;
+ (id) currentCollection;

- (void) sort;
- (id) initWithStops:(NSArray*)array andPlaces:(NSArray*)places;
@end
