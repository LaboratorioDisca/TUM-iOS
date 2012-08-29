//
//  AnnotationsGroups.h
//  TUM
//
//  Created by Alejandro on 8/29/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"
#import <MapBox/MapBox.h>
#import "UIColor-Expanded.h"

#define zeroCoordComponent -1.0f

typedef void (^BasicBlock)(void);
@interface AnnotationsGroups : NSObject {
    NSMutableDictionary *routesAnnotations;
    RMMapView *map;
}

@property (nonatomic, strong) NSMutableDictionary *routesAnnotations;
@property (nonatomic, strong) RMMapView *map;

+ (id) current;
+ (void) startWithMap:(RMMapView*)map;

+ (id) retrieveRouteAnnotationWithIdentifier:(NSString*)identifier;
+ (void) bathProcessRoute:(Route*)route;

- (id) initWithMap:(RMMapView*)mapView;

@end
