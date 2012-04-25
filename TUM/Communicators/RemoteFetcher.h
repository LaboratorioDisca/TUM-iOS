//
//  RemoteFetcher.h
//  TUM
//
//  Created by Alejandro on 25/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteFetcher : NSObject
@property (strong, atomic) NSMutableData *responseData;

+ (void) loadVehicles;
+ (void) loadRoutes;
+ (void) loadInstants;
@end
