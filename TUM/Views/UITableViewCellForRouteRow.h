//
//  UITableViewCellForRouteRow.h
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@interface UITableViewCellForRouteRow : UITableViewCell

- (void) drawRouteDataWith:(Route*)route;

@end
