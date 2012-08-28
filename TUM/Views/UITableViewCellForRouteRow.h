//
//  UITableViewCellForRouteRow.h
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"
#import "UIColor-Expanded.h"
#import <QuartzCore/QuartzCore.h>

@interface UITableViewCellForRouteRow : UITableViewCell

- (void) drawRouteDataWith:(Route*)route;

@end
