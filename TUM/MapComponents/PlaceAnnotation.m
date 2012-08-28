//
//  PlaceAnnotation.m
//  TUM
//
//  Created by Alejandro on 28/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "PlaceAnnotation.h"

@implementation PlaceAnnotation
@synthesize place;

- (id) initWithMapView:(RMMapView *)aMapView andPlace:(Place*)place_
{
    self = [super initWithMapView:aMapView coordinate:place_.coordinate andTitle:@""];
    if (self) {
        self.place = place_;
        
        self.userInfo = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"stop.png"]];
    }
    return self;
}

@end
