//
//  ReactiveFocusView.h
//  TUM
//
//  Created by Alejandro on 24/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverFocusDelegate.h"

@interface ReactiveFocusView : UIView {
    UIView<PopoverFocusDelegate> *delegate;
}

@property (nonatomic, strong) UIView<PopoverFocusDelegate> *delegate;

@end
