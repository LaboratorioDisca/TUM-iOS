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

@interface Routes() {
    
}

- (void) applyCollection:(NSArray*)collection_;

@end

@implementation Routes
@synthesize collection, sortedCollection;

+ (void) loadWithRoutesCollection:(NSArray *)newCollection
{
    Routes *routes = [[Routes alloc] initWithRoutesCollection:newCollection];
    singleton = routes;
}

+ (Routes*) currentCollection 
{
    return singleton;
}

+ (Route*) fetchRouteWithId:(NSNumber *)routeId
{
    return [[singleton collection] objectForKey:routeId];
}

+ (BOOL) areRoutesSelected
{    
    BOOL oneSelected = NO;
    for (Route *route in [[singleton collection] allValues]) {
        if ([route  visibleOnMap]) {
            oneSelected = YES;
            break;
        }
    }
    return oneSelected;
}

- (id) initWithRoutesCollection:(NSArray *)newCollection
{
    if ((self = [self init])) {
        [self applyCollection:newCollection];
        self.sortedCollection = [[[self collection] allValues] sortedArrayUsingComparator:^(id a, id b) {
            NSString *first = [[(Route*)a name] stringByReplacingOccurrencesOfString:@"Ruta " withString:@""];
            NSString *second = [[(Route*)b name] stringByReplacingOccurrencesOfString:@"Ruta " withString:@""];
            
            return [[NSNumber numberWithInteger:[first integerValue]] compare:[NSNumber numberWithInteger:[second integerValue]]];
        }];
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
        [route setSimpleIdentifier:[routeData objectForKey:@"simpleIdentifier"]];
        [dictionary setObject:route forKey:[routeData objectForKey:@"id"]];
    }
    [self setCollection:dictionary];
}



@end
