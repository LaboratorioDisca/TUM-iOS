//
//  Stations.m
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Stations.h"

@implementation Stations
static Stations *singleton;

@synthesize collection;

 + (id) loadStationsFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stations" ofType:@"plist"];
    if (singleton == NULL) {
        singleton = [[Stations alloc] initWithDictionary:[[NSDictionary alloc] initWithContentsOfFile:path]];
    }
    return singleton;
}

+ (id) currentCollection
{
    return singleton;
}

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSNumber* key in [dictionary allKeys]) {
            NSDictionary *subdict = [dictionary objectForKey:key];
            Station *station = [[Station alloc] initWithName:[subdict objectForKey:@"name"] 
                                               andCoordinate:CLLocationCoordinate2DMake([[subdict objectForKey:@"latitude"] floatValue], 
                                                                                        [[subdict objectForKey:@"longitude"] floatValue])];
            [dict setObject:station forKey:key];
        }
        [self setCollection:dict];
    }
    return self;
}

@end
