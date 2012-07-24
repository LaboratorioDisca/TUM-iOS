//
//  InstantRMMarker.h
//  TUM
//
//  Created by Alejandro on 5/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapBox/MapBox.h>
#import "Instant.h"

@interface InstantRMMarker : RMMarker {
    Instant *instant;   
}

@property (nonatomic, strong) Instant* instant;

@end
