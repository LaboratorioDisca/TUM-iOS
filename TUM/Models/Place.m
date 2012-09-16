//
//  Station.m
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Place.h"

@interface Place ()

+ (NSDictionary*) categories;

@end


@implementation Place

static NSDictionary *categories;

@synthesize name, coordinate, category;


+ (NSDictionary*) categories {
    if (!categories) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:@"school" forKey:[NSNumber numberWithInt:0]];
        [dictionary setObject:@"faculty" forKey:[NSNumber numberWithInt:1]];
        [dictionary setObject:@"institute" forKey:[NSNumber numberWithInt:2]];
        [dictionary setObject:@"library" forKey:[NSNumber numberWithInt:3]];
        [dictionary setObject:@"museum" forKey:[NSNumber numberWithInt:4]];
        [dictionary setObject:@"sportCenter" forKey:[NSNumber numberWithInt:5]];
        [dictionary setObject:@"foodStore" forKey:[NSNumber numberWithInt:6]];
        [dictionary setObject:@"restaurant" forKey:[NSNumber numberWithInt:7]];
        [dictionary setObject:@"laboratory" forKey:[NSNumber numberWithInt:8]];
        [dictionary setObject:@"pumabusStop" forKey:[NSNumber numberWithInt:9]];
        [dictionary setObject:@"bicipumaStation" forKey:[NSNumber numberWithInt:10]];
        [dictionary setObject:@"otherBuilding" forKey:[NSNumber numberWithInt:11]];
        [dictionary setObject:@"openSpace" forKey:[NSNumber numberWithInt:12]];
        categories = dictionary;
    }
    return categories;
}

- (id) initWithName:(NSString*)name_ andCoordinate:(CLLocationCoordinate2D)coordinate_ andCategory:(NSNumber*)placeCategory
{
    self = [super init];
    if (self) {
        [self setName:name_];
        [self setCoordinate:coordinate_];
        if (placeCategory != NULL) {
            [self setCategory:placeCategory];
        } else {
            [self setCategory:[NSNumber numberWithInt:9]];
        }
    }
    
    return self;
}

- (NSString*) placeCategory
{
    return NSLocalizedString([[Place categories] objectForKey:self.category], @"localized name for category type");
}


@end
