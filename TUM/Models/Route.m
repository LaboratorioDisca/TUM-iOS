//
//  Route.m
//  TUM
//
//  Created by Alejandro on 02/05/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "Route.h"

@interface Route() {
    
}

- (NSString*) fixEncodingFor:(NSString*)string;

@end

@implementation Route
@synthesize name, color, identifier, leftTerminal, rightTerminal, coordinates, visibleOnMap, simpleIdentifier;

- (id) initWithName:(NSString *)name_ withLeftTerminal:(NSString *)leftTerminal_ withRightTerminal:(NSString *)rightTerminal_ withId:(NSNumber *)identifier_ withColor:(NSString*)color_ withCoordinates:(NSArray *)coordinates_ {
    if ((self = [super init])) {
        self.name = name_;
        self.leftTerminal = [self fixEncodingFor:leftTerminal_];
        self.rightTerminal = [self fixEncodingFor:rightTerminal_];
        self.identifier = identifier_;
        self.coordinates = coordinates_;
        self.color = [[NSString stringWithString:@"0x"] stringByAppendingString:[color_ substringFromIndex:1]];
        self.visibleOnMap = NO;
    }
    
    return self;
}

- (NSString*) fixEncodingFor:(NSString *)string
{
    char converted[([string length] + 1)];
    [string getCString:converted maxLength:([string length] + 1) encoding: NSISOLatin1StringEncoding];
    return [NSString stringWithCString:converted encoding:NSUTF8StringEncoding];
}

- (NSString*) directions
{
    return [[leftTerminal stringByAppendingString:@" - "] stringByAppendingString:rightTerminal];
}

@end
