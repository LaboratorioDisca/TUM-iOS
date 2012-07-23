//
//  OvermapButton.h
//  TUM
//
//  Created by Alejandro on 07/05/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationConfig.h"
#import <QuartzCore/QuartzCore.h>
#import "ActionButton.h"

@interface OvermapButton : UIButton<ActionButton>

- (id) initWithImageNamed:(NSString*)imageName;

- (void) blink;

@end
