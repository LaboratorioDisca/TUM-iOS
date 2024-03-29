//
//  AboutViewController.h
//  TUM
//
//  Created by Alejandro on 28/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "IIViewDeckController.h"
#import <QuartzCore/QuartzCore.h>
#import "ExtendedAboutViewController.h"
#import "ControllerIconDelegate.h"

#define kPages 3

@interface AboutViewController : TabBarViewController<UIScrollViewDelegate, ControllerIconDelegate>

- (void) pageChanged;

@end
