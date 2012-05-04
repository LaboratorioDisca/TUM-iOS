//
//  Route.m
//  TUM
//
//  Created by Alejandro on 02/05/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Route.h"

@implementation Route
@synthesize name, color, identifier, leftTerminal, rightTerminal, coordinates;

- (id) initWithName:(NSString *)name_ withLeftTerminal:(NSString *)leftTerminal_ withRightTerminal:(NSString *)rightTerminal_ withId:(NSNumber *)identifier_ withColor:(NSString*)color_ withCoordinates:(NSArray *)coordinates_ {
    if ((self = [super init])) {
        self.name = name_;
        self.leftTerminal = leftTerminal_;
        self.rightTerminal = rightTerminal_;
        self.identifier = identifier_;
        self.coordinates = coordinates_;
        self.color = [[NSString stringWithString:@"0x"] stringByAppendingString:[color_ substringFromIndex:1]];
    }
    
    return self;
}

@end
