//
//  Vehicle.h
//  TUM
//
//  Created by Alejandro on 5/10/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject {
    NSNumber *uniqueIdentifier;
    NSNumber *identifier;
    NSNumber *lineId;
}

@property (strong, atomic) NSNumber *uniqueIdentifier;
@property (strong, atomic) NSNumber *identifier;
@property (strong, atomic) NSNumber *lineId;

- (id) initWithUniqueIdentifier:(NSString*)uid withIdentifier:(NSNumber*)identifier withLineId:(NSNumber*)lineId;

@end
