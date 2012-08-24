//
//  PopoverMenuItemDelegate.h
//  TUM
//
//  Created by Alejandro on 24/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopoverActionMenuItemDelegate <NSObject>

@required
- (void) reactToPopoverItemSelectedWith:(int)number;
- (void) clearViewForPopover;
@end
