//
//  Routes.m
//  TUM
//
//  Created by Alejandro on 25/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Routes.h"
#import "Route.h"
static NSDictionary* collection;

@implementation Routes

+ (void) setCollection:(NSArray *)collection_
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSDictionary *routeData in dictionary) {
        Route * route = [[Route alloc] initWithName:[routeData objectForKey:@"name"] 
                                   withLeftTerminal:[routeData objectForKey:@"leftTerminal"] 
                                  withRightTerminal:[routeData objectForKey:@"rightTerminal"] 
                                             withId:[routeData objectForKey:@"id"]  
                                          withColor:[[routeData objectForKey:@"color"] intValue] 
                                    withCoordinates:[routeData objectForKey:@"paths"]];
        [dictionary setObject:[routeData objectForKey:@"id"] forKey:route];
    }
    collection = dictionary;
}

+ (NSDictionary*) collection
{
    return collection;
}


@end
