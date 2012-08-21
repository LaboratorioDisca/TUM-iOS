//
//  Stations.h
//  TUM
//
//  Created by Alejandro on 21/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@interface Stations : NSObject {
    NSDictionary *collection;
}

@property (nonatomic, strong) NSDictionary *collection;

+ (id) loadStationsFromFile;
+ (id) currentCollection;


- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
