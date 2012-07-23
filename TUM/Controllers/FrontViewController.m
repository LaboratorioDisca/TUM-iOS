//
//  FrontViewController.m
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "FrontViewController.h"
#import "ApplicationConfig.h"

@implementation FrontViewController


- (id) init
{
    self = [super init];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:[ApplicationConfig viewBounds]];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"texture.jpg"]]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"muevete.png"]];
        [imgView setCenter:CGPointMake([ApplicationConfig viewBounds].size.width/2, 20+[[imgView image] size].height/2)];
        [self.view addSubview:imgView];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
