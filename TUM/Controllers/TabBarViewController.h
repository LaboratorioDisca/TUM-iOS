//
//  TabBarViewController.h
//  TUM
//
//  Created by Alejandro on 08/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor-Expanded.h"
#import "ApplicationConfig.h"
#import <QuartzCore/QuartzCore.h>

@interface TabBarViewController : UIViewController {
    UINavigationBar *navigationBar;
    UIButton *rightButton;
    UIButton *secondRightButton;
    UIButton *leftButton;
    UILabel *navigationBarTitle;
    
    BOOL rightButtonEnabled;
    BOOL leftButtonEnabled;
    BOOL secondRightButtonEnabled;
}

@property (nonatomic, strong) UILabel *navigationBarTitle;
@property (nonatomic, assign) BOOL rightButtonEnabled;
@property (nonatomic, assign) BOOL secondRightButtonEnabled;
@property (nonatomic, assign) BOOL leftButtonEnabled;
@property (nonatomic, strong) UINavigationBar *navigationBar;

- (void) navBarCustomization;
- (void) onLeftControlActivate;
- (void) onRightControlActivate;
- (void) onSecondRightControlActivate;

@end
