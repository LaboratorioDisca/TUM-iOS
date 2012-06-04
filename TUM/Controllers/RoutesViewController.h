//
//  RoutesViewController.h
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"

@interface RoutesViewController : UITableViewController<ASIHTTPRequestDelegate>

- (void) fetchRoutes;
@end
