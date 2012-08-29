//
//  AnnotationsGroups.m
//  TUM
//
//  Created by Alejandro on 8/29/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "AnnotationsGroups.h"
#import "NSThread+Blocks.h"

@interface AnnotationsGroups () {
    
}

@end

@implementation AnnotationsGroups
@synthesize routesAnnotations, map;

static AnnotationsGroups *singleton;

+ (id) current
{
    return singleton;
}

+ (void) startWithMap:(RMMapView *)map
{
    if (singleton == NULL) {
        singleton = [[AnnotationsGroups alloc] initWithMap:map];
    }
}

+ (id) retrieveRouteAnnotationWithIdentifier:(NSString *)identifier
{
    return [[[AnnotationsGroups current] routesAnnotations] objectForKey:identifier];
}

+ (void) bathProcessRoute:(Route *)route 
{
    AnnotationsGroups *current = [AnnotationsGroups current];
    RMMapView *map = [current map];
    RMAnnotation *annotation = [[current routesAnnotations] objectForKey:route.identifier.stringValue];
    if (annotation == NULL) {
        [NSThread performSelectorInBackground:@selector(MCSM_runBlock:)
                               withObject:[^{
            RMShape *path = [[RMShape alloc] initWithView:map];
            [path setLineColor:[UIColor colorWithHexString:route.color]];
            [path setLineWidth:3];
            
            // store first coordinates for annotation positioning
            double latF = zeroCoordComponent;
            double lonF = zeroCoordComponent;
            
            double lat = zeroCoordComponent;
            double lon = zeroCoordComponent;
            
            NSMutableArray *locations = [NSMutableArray array];
            for (NSDictionary *coordinates in [route coordinates]) {
                if (lat != zeroCoordComponent && lon != zeroCoordComponent) {
                    [path moveToCoordinate:CLLocationCoordinate2DMake(lat, lon)];
                }
                
                lat = [[coordinates objectForKey:@"lat"] doubleValue];
                lon = [[coordinates objectForKey:@"lon"] doubleValue];
                
                if (latF == zeroCoordComponent && lonF == zeroCoordComponent) {
                    latF = lat;
                    lonF = lon;
                }
                
                [path addLineToCoordinate:CLLocationCoordinate2DMake(lat, lon)];
                [locations addObject:[[CLLocation alloc] initWithLatitude:lat longitude:lon]];
            }
            [path closePath];
            
            RMAnnotation *annotation = [[RMAnnotation alloc]initWithMapView:map 
                                                                 coordinate:CLLocationCoordinate2DMake(latF, lonF)
                                                                   andTitle:@""];
            [annotation setUserInfo:path];
            [annotation setHasBoundingBox:YES];
            [annotation setBoundingBoxFromLocations:locations];
            
            [[[AnnotationsGroups current] routesAnnotations] setObject:annotation forKey:route.identifier.stringValue];
            
            [map performSelectorOnMainThread:@selector(removeAnnotation:) withObject:annotation waitUntilDone:YES];
            if ([route visibleOnMap]) {
                [map performSelectorOnMainThread:@selector(addAnnotation:) withObject:annotation waitUntilDone:NO];
            }        
        } copy]];
    } else {
        [map removeAnnotation:annotation];
        if ([route visibleOnMap]) {
            [map addAnnotation:annotation];
        }
    }
}
     
- (id) initWithMap:(RMMapView *)mapView
{
    self = [super init];
    if (self) {
        map = mapView;
        [self setRoutesAnnotations:[NSMutableDictionary dictionary]];
    }
    return self;
}


@end
