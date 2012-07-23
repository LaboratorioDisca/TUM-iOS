//
//  Instants.h
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instants : NSObject {
    NSMutableDictionary *collection;
}

@property (atomic, strong) NSMutableDictionary *collection;

+ (void) loadWithInstantsCollection:(NSArray*)collection_;
+ (id) currentCollection;

- (void) updateCollectionWithCollection:(NSArray*)collection_;

@end

