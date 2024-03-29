//
//  Routes.h
//  TUM
//
//  Created by Alejandro on 25/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

@interface Routes : NSObject {
    NSDictionary *collection;
    NSArray *sortedCollection;
}

@property (nonatomic, strong) NSDictionary *collection;
@property (nonatomic, strong) NSArray *sortedCollection;

+ (void) loadWithRoutesCollection:(NSArray*)collection;
+ (Routes*) currentCollection;
+ (Route*) fetchRouteWithId:(NSNumber*)routeId;
+ (BOOL) areRoutesSelected;
- (id) initWithRoutesCollection:(NSArray*)collection;

@end
