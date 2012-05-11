//
//  Route.h
//  TUM
//
//  Created by Alejandro on 02/05/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject {
    NSString *name;
    NSString *leftTerminal;
    NSString *rightTerminal;
    NSNumber *identifier;
    NSArray *coordinates;
    NSString *color;
    
    BOOL visibleOnMap;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *leftTerminal;
@property (nonatomic, strong) NSString *rightTerminal;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSArray  *coordinates;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *simpleIdentifier;
@property BOOL visibleOnMap;

- (id) initWithName:(NSString*)name 
   withLeftTerminal:(NSString*)leftTerminal 
  withRightTerminal:(NSString*)rightTerminal 
             withId:(NSNumber*)identifier 
          withColor:(NSString*)color 
    withCoordinates:(NSArray*)coordinates;

- (NSString*) directions;

@end
