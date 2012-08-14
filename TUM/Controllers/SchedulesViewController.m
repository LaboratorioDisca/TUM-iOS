//
//  SchedulesViewController.m
//  TUM
//
//  Created by Alejandro on 08/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "SchedulesViewController.h"

@interface SchedulesViewController ()

@end

@implementation SchedulesViewController

- (id) init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor grayColor]];
        [self setLeftButtonEnabled:YES];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewDeckController setPanningMode:IIViewDeckNoPanning];
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
