//
//  VehicleAnnotation.h
//  TUM
//
//  Created by Alejandro on 16/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <MapBox/MapBox.h>
#import "Route.h"
#import "Instant.h"

@interface VehicleAnnotation : RMAnnotation {
    Instant *instant;
    Route *route;
}

@property (nonatomic, readonly) Instant* instant;
@property (nonatomic, strong) Route* route;

+ (UIImage*) getOrRegisterMarkerWith:(NSString*)markerName;
+ (UIImage*) defaultSelectedMarker;

- (id) initWithMapView:(RMMapView *)aMapView instant:(Instant*)instant andRoute:(Route*)route;
- (void) markAsSelected;
- (void) markAsDeselected;
- (void) setInstant:(Instant *)instant;
@end
