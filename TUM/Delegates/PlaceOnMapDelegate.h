//
//  LocationOnMapDelegate.h
//  TUM
//
//  Created by Alejandro on 27/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@protocol PlaceOnMapDelegate<NSObject>

@required
- (void) setPlaceOnMap:(Place*)place;
@end
