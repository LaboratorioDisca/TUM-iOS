//
//  ApplicationConfig.h
//  tiu
//
//  Created by Alejandro on 3/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kZOOM           16
#define kMenuHeight     100

@interface ApplicationConfig : NSObject 

+ (CLLocationCoordinate2D) coordinates;
+ (CGRect) viewBounds;
+ (NSString*) backendURL;
+ (NSString*) urlForResource:(NSString *)resource;
+ (NSString*) defaultFont;

@end
