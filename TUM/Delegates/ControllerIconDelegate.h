//
//  ControllerIconDelegate.h
//  TUM
//
//  Created by Alejandro Cruz Paz on 9/25/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ControllerIconDelegate <NSObject>

@required
- (NSString*) iconImageName;
- (NSString*) title;

@end
