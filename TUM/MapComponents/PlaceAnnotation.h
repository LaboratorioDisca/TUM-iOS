//
//  PlaceAnnotation.h
//  TUM
//
//  Created by Alejandro on 28/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <MapBox/MapBox.h>
#import "Place.h"

@interface PlaceAnnotation : RMAnnotation {
    Place *place;
}

@property (nonatomic, strong) Place* place;

- (id) initWithMapView:(RMMapView *)aMapView andPlace:(Place*)place;

@end
