//
//  Station.m
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize name, coordinate;

- (id) initWithName:(NSString*)name_ andCoordinate:(CLLocationCoordinate2D)coordinate_
{
    self = [super init];
    if (self) {
        [self setName:name_];
        [self setCoordinate:coordinate_];
    }
    
    return self;
}


@end
