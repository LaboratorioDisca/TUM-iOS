//
//  Places.h
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface Places : NSObject {
    NSDictionary *collection;
}

@property (nonatomic, strong) NSDictionary *collection;

+ (id) loadStationsFromFile;
+ (id) currentCollection;


- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
