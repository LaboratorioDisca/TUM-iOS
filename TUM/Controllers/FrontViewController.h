//
//  FrontViewController.h
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIHTTPRequest.h"
#import "ApplicationConfig.h"
#import "Gradients.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor-Expanded.h"
#import "IIViewDeckController.h"
#import "ControllerIconDelegate.h"

@interface FrontViewController : UIViewController<ASIHTTPRequestDelegate, ControllerIconDelegate>

- (void) updateStatusMessageWithValue:(NSString*)message;
- (void) fetchServiceStatus;

@end
