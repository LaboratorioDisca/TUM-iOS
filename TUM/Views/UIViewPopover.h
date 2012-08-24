//
//  UIViewPopover.h
//  TUM
//
//  Created by Alejandro on 24/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationConfig.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor-Expanded.h"
#import "PopoverFocusDelegate.h"
#import "PopoverActionMenuItemDelegate.h"

#define kWidth 135
#define kHeight 110
#define kMarginTop 55
#define kMarignLeft 10

@interface UIViewPopover : UIView<PopoverFocusDelegate> {
    UIViewController<PopoverActionMenuItemDelegate> *delegate;
}

@property (nonatomic, strong) UIViewController<PopoverActionMenuItemDelegate> *delegate;

- (id) initOnRightPositionWithItems:(NSArray*)items;

@end
