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

@interface FrontViewController : UIViewController<ASIHTTPRequestDelegate>

- (void) updateStatusMessageWithValue:(NSInteger)value;
- (void) fetchServiceStatus;

@end
