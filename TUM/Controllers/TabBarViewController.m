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

@synthesize navigationBarTitle;

- (id) init
{
    self = [super init];
    if (self) {
        navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 40)];
        navigationBarTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 40)];
        [navigationBarTitle setBackgroundColor:[UIColor clearColor]];
        [navigationBarTitle setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        [navigationBarTitle.layer setShadowOpacity:0.6];
        [navigationBarTitle.layer setShadowOffset:CGSizeMake(0.0, -1.0)];
        [navigationBarTitle.layer setShadowColor:[UIColor blackColor].CGColor];

        [navigationBarTitle setTextAlignment:UITextAlignmentCenter];
        [navigationBarTitle setTextColor:[UIColor whiteColor]];
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
    [navigationBar setBarStyle:UIBarStyleBlackOpaque];
    //[navigationBar setTintColor:[UIColor colorWithHexString:@"0x5485f9"]];
    
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake([ApplicationConfig viewBounds].size.width-50, 2.5, 40, 33)];
    [rightButton setImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(onRightControlActivate) forControlEvents:UIControlEventTouchUpInside];
    
    //[navigationBar addSubview:rightButton];
    
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 2.1, 40, 36)];
    [leftButton setImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onLeftControlActivate) forControlEvents:UIControlEventTouchUpInside];
    
    [navigationBarTitle setText:self.title];
    [navigationBar addSubview:navigationBarTitle];
    //[navigationBar addSubview:leftButton];
    [self.view addSubview:navigationBar];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [navigationBar removeFromSuperview];
}

@end
