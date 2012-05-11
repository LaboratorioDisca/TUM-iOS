//
//  ConfigurationGlobals.m
//  tiu
//
//  Created by Alejandro on 3/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "ApplicationConfig.h"

@implementation ApplicationConfig

+ (CGRect) viewBounds
{
    return [[UIScreen mainScreen] bounds];
}

+ (CLLocationCoordinate2D) coordinates
{
    return CLLocationCoordinate2DMake(19.322675, -99.192080);
}

@end
