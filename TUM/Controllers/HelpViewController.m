//
//  HelpViewController.m
//  TUM
//
//  Created by Alejandro on 08/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (id) init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithHexString:@"AD8A0C"]];
        [self setLeftButtonEnabled:YES];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewDeckController setPanningMode:IIViewDeckNoPanning];

    UILabel *one = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, [ApplicationConfig viewBounds].size.width, 40)];
    [one setTextAlignment:UITextAlignmentRight];
    
    [one setTextColor:[UIColor whiteColor]];
    [one setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
    [one setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [one setText:@"1"];
    [self.view addSubview:one];
}

- (void) onLeftControlActivate
{
    [self.viewDeckController openLeftView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
