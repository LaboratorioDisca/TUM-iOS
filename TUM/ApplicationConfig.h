//
//  ApplicationConfig.h
//  tiu
//
//  Created by Alejandro on 3/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define backendURL      @"http://132.248.51.251"
#define kZOOM           16
#define kMenuHeight     100

@interface ApplicationConfig : NSObject 

+ (CLLocationCoordinate2D) coordinates;

+ (CGRect) viewBounds;

@end
