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

+ (CGPoint) coordinates
{
    return CGPointMake(19.322675, -99.192080);
}

+ (CGRect) mapBounds
{
    CGRect view=[self viewBounds];
    return CGRectMake(view.origin.x, view.origin.y, view.size.width, view.size.height-kMenuHeight);
}

+ (CGRect) menuBounds
{
    CGRect view=[self viewBounds];
    return CGRectMake(view.origin.x, view.size.height, view.size.width, kMenuHeight);
}

@end
