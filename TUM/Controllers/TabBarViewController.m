//
//  TabBarViewController.m
//  TUM
//
//  Created by Alejandro on 08/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

@synthesize navigationBarTitle, leftButtonEnabled, secondRightButtonEnabled, rightButtonEnabled, navigationBar;

- (id) init
{
    self = [super init];
    if (self) {
        navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 45)];
        navigationBarTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 45)];
        [navigationBarTitle setBackgroundColor:[UIColor clearColor]];
        [navigationBarTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
        [navigationBarTitle.layer setShadowOpacity:0.6];
        [navigationBarTitle.layer setShadowOffset:CGSizeMake(0.0, -1.0)];
        [navigationBarTitle.layer setShadowColor:[UIColor blackColor].CGColor];

        [navigationBarTitle setTextAlignment:UITextAlignmentCenter];
        [navigationBarTitle setTextColor:[UIColor whiteColor]];
        
        rightButtonEnabled = NO;
        leftButtonEnabled = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self navBarCustomization];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) navBarCustomization
{
    [navigationBar setTintColor:[UIColor colorWithHexString:@"0x0E223D"]];

    //[navigationBar setTintColor:[UIColor colorWithHexString:@"0x5485f9"]];
    
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 3, 50, 38)];
    [leftButton setImage:[UIImage imageNamed:@"menu_button.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onLeftControlActivate) forControlEvents:UIControlEventTouchUpInside];
    
    [navigationBarTitle setText:self.title];
    [navigationBar addSubview:navigationBarTitle];
    
    [self.view addSubview:navigationBar];
    

    if (leftButtonEnabled) {
        [navigationBar addSubview:leftButton];
    }
    
    if (rightButtonEnabled) {
        //[navigationBar addSubview:rightButton];
    }
    
    if (secondRightButtonEnabled) {
        //[navigationBar addSubview:secondRightButton];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [navigationBar removeFromSuperview];
}

- (void) onLeftControlActivate
{
    
}

- (void) onRightControlActivate
{
    
}

- (void) onSecondRightControlActivate
{
    
}

@end
