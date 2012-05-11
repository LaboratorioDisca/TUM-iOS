//
//  Instants.h
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstantsReceiverDelegate.h"

@interface Instants : NSObject {
    NSMutableDictionary *collection;
    id<InstantsReceiverDelegate> receiverDelegate;
}

@property (atomic, strong) NSMutableDictionary *collection;
@property (nonatomic, strong) id<InstantsReceiverDelegate> receiverDelegate;

+ (void) initializeWithDelegate:(id<InstantsReceiverDelegate>)delegate;
+ (void) loadWithInstantsCollection:(NSArray*)collection_;
+ (id) currentCollection;

- (void) updateCollectionWithCollection:(NSArray*)collection_;

@end

