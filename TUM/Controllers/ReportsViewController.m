//
//  ReportsViewController.m
//  TUM
//
//  Created by Alejandro on 5/12/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "ReportsViewController.h"
#import "HelpButton.h"
#import "ApplicationConfig.h"

@interface ReportsViewController() {
    
}

- (void) segmentAction:(id)segment;

@end

@implementation ReportsViewController
@synthesize segmentedControl;

- (id) init
{
    self = [super init];
    if (self) {
        [self setView:[[UIView alloc] initWithFrame:[ApplicationConfig viewBounds]]];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        [self setSegmentedControl:[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Accidente", @"Robo", @"Incendio", nil]]];
        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControl.momentary = YES;
        segmentedControl.tintColor = [UIColor lightGrayColor];
        segmentedControl.center = CGPointMake(160, 70);
        [segmentedControl setWidth:110 forSegmentAtIndex:0];
        [segmentedControl setWidth:90 forSegmentAtIndex:1];
        [segmentedControl setWidth:100 forSegmentAtIndex:2];
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

    }
    return self;
}

- (void) segmentAction:(id)segment
{
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
    }
    else{
        //toggle the correct view to be visible

    }

}

- (void) viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    [self.view addSubview:[[HelpButton alloc] init]];
    [self.view addSubview:segmentedControl];    
}

@end
