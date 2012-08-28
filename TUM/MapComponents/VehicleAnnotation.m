//
//  VehicleAnnotation.m
//  TUM
//
//  Created by Alejandro on 16/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "VehicleAnnotation.h"

@implementation VehicleAnnotation

@synthesize instant, route;

static NSMutableDictionary *markers;

- (id) initWithMapView:(RMMapView *)aMapView instant:(Instant*)instant_ andRoute:(Route*)route_
{
    self = [super initWithMapView:aMapView coordinate:instant_.coordinates andTitle:@""];
    if (self) {
        self.anchorPoint = CGPointMake(10, 10);
        self.instant = instant_;
        self.route = route_;
        
        UIImage* img = [VehicleAnnotation getOrRegisterMarkerWith:route.simpleIdentifier];
        self.userInfo = [[RMMarker alloc] initWithUIImage:img anchorPoint:CGPointMake(0.5, 1)];
    }
    return self;
}
             
+ (UIImage*) getOrRegisterMarkerWith:(NSString *)markerName
{
    if (markers == NULL) {
        markers = [NSMutableDictionary dictionary];
    }
    
    if ([markers objectForKey:markerName] == NULL) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", markerName]];
        [markers setObject:image forKey:markerName];
    }
    
    return [markers objectForKey:markerName];
}

+ (UIImage*) defaultSelectedMarker
{
    return [self getOrRegisterMarkerWith:@"bus"];
}

- (void) markAsSelected
{
    [self.userInfo replaceUIImage:[VehicleAnnotation defaultSelectedMarker] anchorPoint:CGPointMake(0.5, 1)];
}

- (void) markAsDeselected
{
    [self.userInfo replaceUIImage:[VehicleAnnotation getOrRegisterMarkerWith:route.simpleIdentifier] anchorPoint:CGPointMake(0.5, 1)];
}

- (void) setInstant:(Instant *)instant_
{
    instant = instant_;
    self.coordinate = instant.coordinates;
}

@end
