//
//  FrontViewController.m
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "FrontViewController.h"
#import "ApplicationConfig.h"
#import "Gradients.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor-Expanded.h"

@implementation FrontViewController {

    UILabel *statusLabel; 
    UILabel *statusValue; 
    UIActivityIndicatorView *indicator; 
}

- (id) init
{
    self = [super init];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:[ApplicationConfig viewBounds]];
                
        CAGradientLayer *bgLayer = [Gradients blueGradient];
        bgLayer.frame = self.view.bounds;
        [self.view.layer insertSublayer:bgLayer atIndex:0];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        [imgView setCenter:CGPointMake([ApplicationConfig viewBounds].size.width/2, 150)];
        [self.view addSubview:imgView];
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.center = CGPointMake(250, 25);
        [indicator startAnimating];
        
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(-2, 320, [ApplicationConfig viewBounds].size.width+4, 50)];
        [statusView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.4]];
        
        [statusView addSubview:indicator];

        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 40)];
        [statusLabel setText:NSLocalizedString(@"service_status_legend", @"")];
        [statusLabel setFont:[UIFont fontWithName:@"GillSans" size:14]];
        [statusLabel setTextColor:[UIColor colorWithWhite:1 alpha:0.6]];
        [statusLabel setBackgroundColor:[UIColor clearColor]];

        statusValue = [[UILabel alloc] initWithFrame:CGRectMake(220, 5, 100, 40)];
        [statusValue setBackgroundColor:[UIColor clearColor]];
        [statusValue setFont:[UIFont fontWithName:@"GillSans" size:14]];


        [statusView addSubview:statusLabel];
        [statusView addSubview:statusValue];

        [self.view addSubview:statusView];
    }
    return self;
}

- (void) updateStatusMessageWithValue:(NSString*)message
{
    NSDate *date = [NSDate date];
    
    NSInteger value = [message integerValue];
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSHourCalendarUnit;  
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date];
    int hour = [breakdownInfo hour]; 
    //if (hour >= 21) {

    if(value > 8) {
        [statusValue setText:NSLocalizedString(@"service_status_normal", @"")];
        [statusValue setTextColor:[UIColor colorWithRGBHex:0x0E870C]];
    } else if(value <= 8 && value >= 3) {
        [statusValue setText:NSLocalizedString(@"service_status_few", @"")];
        [statusValue setTextColor:[UIColor colorWithRGBHex:0xE8CE2D]];
    } else if(value > 0 && value < 3) {
        [statusValue setText:NSLocalizedString(@"service_status_very_few", @"")];
        [statusValue setTextColor:[UIColor redColor]];
    } else if(value == 0 && hour >= 21) {
        [statusValue setText:NSLocalizedString(@"service_status_stopped", @"")];
        [statusValue setTextColor:[UIColor blackColor]];
    } else {
        [statusValue setText:NSLocalizedString(@"service_status_unknown", @"")];
        [statusValue setTextColor:[UIColor blackColor]];
    }
    /*    
    } else {
        [statusLabel setText:@"Precisión en pumabuses:"];
        if(value > 8) {
            [statusValue setText:@"Alta"];
            [statusValue setTextColor:[UIColor colorWithString:@"#0E870C"]];
        } else if(value <= 8 && value >= 3) {
            [statusValue setText:@"Media"];
            [statusValue setTextColor:[UIColor colorWithString:@"#E8CE2D"]];
        } else if(value == 0) {
            [statusValue setText:@"Baja"];
            [statusValue setTextColor:[UIColor blackColor]];
        }
    }
    */
    [indicator stopAnimating];
    [statusValue setHidden:NO];
}

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) fetchServiceStatus
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[ApplicationConfig urlForResource:@"serviceStatus"]]];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self performSelector:@selector(updateStatusMessageWithValue:) withObject:[request responseString] afterDelay:2];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    // Retrieve from local storage (TODO)
    //NSError *error = [request error];
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated
{
    [indicator startAnimating];
    [self fetchServiceStatus];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [indicator stopAnimating];
    [statusValue setHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
