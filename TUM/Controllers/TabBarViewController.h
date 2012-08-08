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
    UIButton *leftButton;
    UILabel *navigationBarTitle;
}

@property (nonatomic, strong) UILabel *navigationBarTitle;

- (void) navBarCustomization;

@end
