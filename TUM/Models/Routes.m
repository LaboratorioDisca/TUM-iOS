//
//  Routes.m
//  TUM
//
//  Created by Alejandro on 25/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Routes.h"
#import "Route.h"
static Routes *singleton;

@implementation Routes
@synthesize collection;

+ (void) loadWithRoutesCollection:(NSArray *)newCollection
{
    Routes *routes = [[Routes alloc] initWithRoutesCollection:newCollection];
    singleton = routes;
}

+ (Routes*) currentCollection 
{
    return singleton;
}

- (id) initWithRoutesCollection:(NSArray *)newCollection
{
    if ((self = [self init])) {
        [self applyCollection:newCollection];
    }
    return self;
}

- (void) applyCollection:(NSArray*)collection_ {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSDictionary *routeData in collection_) {
        Route * route = [[Route alloc] initWithName:[routeData objectForKey:@"name"] 
                                   withLeftTerminal:[routeData objectForKey:@"leftTerminal"] 
                                  withRightTerminal:[routeData objectForKey:@"rightTerminal"] 
                                             withId:[routeData objectForKey:@"id"]  
                                          withColor:[routeData objectForKey:@"color"] 
                                    withCoordinates:[[routeData objectForKey:@"paths"] objectAtIndex:0]];
        [dictionary setObject:route forKey:[routeData objectForKey:@"id"]];
    }
    [self setCollection:dictionary];
}



@end
