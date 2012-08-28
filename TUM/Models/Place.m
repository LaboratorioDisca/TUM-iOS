//
//  Station.m
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize name, coordinate, category;

- (id) initWithName:(NSString*)name_ andCoordinate:(CLLocationCoordinate2D)coordinate_
{
    self = [super init];
    if (self) {
        [self setName:name_];
        [self setCoordinate:coordinate_];
        [self setCategory: STOP];
    }
    
    return self;
}

- (NSString*) placeCategory
{
    if (self.category == STOP) {
        return NSLocalizedString(@"stop", @"stop localized name");
    } else {
        return NSLocalizedString(@"other", @"other localized name");
    }
}


@end
