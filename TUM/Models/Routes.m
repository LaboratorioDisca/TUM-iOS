//
//  Routes.m
//  TUM
//
//  Created by Alejandro on 25/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Routes.h"
static NSDictionary* collection;

@implementation Routes


+ (void) setCollection:(NSDictionary *)collection_
{
    NSLog([collection_ description]);
    collection = collection_;
}


@end
