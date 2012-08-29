//
//  ConfigurationGlobals.m
//  tiu
//
//  Created by Alejandro on 3/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "ApplicationConfig.h"
#define routesDefinitionFile    @"routes.plist"


static NSDictionary* routes;
@interface ApplicationConfig()
+ (void) loadRoutes;
@end

@implementation ApplicationConfig

+ (CGRect) viewBounds
{
    return [[UIScreen mainScreen] bounds];
}

+ (CLLocationCoordinate2D) coordinates
{
    return CLLocationCoordinate2DMake(19.3271, -99.1857);
}

+ (NSString*) backendURL
{
    return [routes objectForKey:@"backendURL"];
}

+ (NSString*) urlForResource:(NSString *)resource
{
    [self loadRoutes];
    return [[self backendURL] stringByAppendingString:[routes objectForKey:resource]];
}

+ (void) loadRoutes
{
    if(routes == NULL) {
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:routesDefinitionFile];
        routes = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    }
}

+ (NSString*) defaultFont
{
    return @"Helvetica-Bold";
}


@end
