//
//  Places.m
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Places.h"

@interface Places()

- (void) buildPlaceInstancesWithFetchedPlaces:(NSArray *)array onTempArrayCollection:(NSMutableArray*)tmpCollection ignoringCategory:(BOOL)ignoreCategory;

@end

@implementation Places
static Places *singleton;

@synthesize collection;

 + (id) loadAllPlaces
{
    if (singleton == NULL) {
        NSString *stopsPath = [[NSBundle mainBundle] pathForResource:@"stations" ofType:@"plist"];
        NSString *placesPath = [[NSBundle mainBundle] pathForResource:@"places" ofType:@"plist"];
        singleton = [[Places alloc] initWithStops:[[[NSDictionary alloc] initWithContentsOfFile:stopsPath] allValues]
                                        andPlaces:[[[NSDictionary alloc] initWithContentsOfFile:placesPath] allValues]];
    }
    return singleton;
}

+ (id) currentCollection
{
    return singleton;
}

- (void) sort
{
    [self setCollection:[collection sortedArrayUsingComparator:^(id a, id b) {
        return [[(Place*) a name] compare:[(Place*) b name]];
    }]];
}

- (id) initWithStops:(NSArray *)stops andPlaces:(NSArray *)places
{
    self = [super init];
    NSMutableArray *tmpCollection = [NSMutableArray array];

    if (self) {
        [self buildPlaceInstancesWithFetchedPlaces:stops onTempArrayCollection:tmpCollection ignoringCategory:YES];
        [self buildPlaceInstancesWithFetchedPlaces:places onTempArrayCollection:tmpCollection ignoringCategory:NO];
        [self setCollection:tmpCollection];
        [self sort];
    }
    return self;
}

- (void) buildPlaceInstancesWithFetchedPlaces:(NSArray *)array
                        onTempArrayCollection:(NSMutableArray *)tmpCollection
                             ignoringCategory:(BOOL)ignoreCategory
{
    NSLog([NSString stringWithFormat:@"Count: %d", array.count]);
    for (NSDictionary * dictionary in array) {
        
        NSNumber *category = NULL;
        if (!ignoreCategory) {
            category = [dictionary objectForKey:@"category"];
        }
        
        Place *place = [[Place alloc] initWithName:[dictionary objectForKey:@"name"]
                                     andCoordinate:CLLocationCoordinate2DMake([[dictionary objectForKey:@"latitude"] floatValue],
                                                                              [[dictionary objectForKey:@"longitude"] floatValue])
                                       andCategory:category];
        [tmpCollection addObject:place];
    }
}

@end
