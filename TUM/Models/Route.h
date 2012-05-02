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
    NSDictionary *coordinates;
    int color;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *leftTerminal;
@property (nonatomic, strong) NSString *rightTerminal;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSDictionary* coordinates;
@property int color;

- (id) initWithName:(NSString*)name 
   withLeftTerminal:(NSString*)leftTerminal 
  withRightTerminal:(NSString*)rightTerminal 
             withId:(NSNumber*)identifier 
          withColor:(int)color 
    withCoordinates:(NSDictionary*)coordinates;

@end
