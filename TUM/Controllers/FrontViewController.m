//
//  FrontViewController.m
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "FrontViewController.h"

@interface FrontViewController() {
    UIImageView *startIcon;
    UIButton *start;
    BOOL menuViewVisible;

}

- (void) drawStartControls;
- (void) drawStatusControls;
- (void) onStartButtonTap;
@end

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
        
        menuViewVisible = NO;
        [self drawStatusControls];
        [self drawStartControls];
    }
    return self;
}

- (void) drawStatusControls
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [imgView setCenter:CGPointMake([ApplicationConfig viewBounds].size.width/2, 150)];
    [self.view addSubview:imgView];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(170, 25);
    [indicator startAnimating];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(110, 320, [ApplicationConfig viewBounds].size.width-110, 50)];
    [statusView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.4]];
    [statusView.layer setShadowOffset:CGSizeMake(2, 2)];
    [statusView.layer setShadowOpacity:0.8];
    [statusView.layer setShadowRadius:2];
    [statusView.layer setShadowColor:[UIColor blackColor].CGColor];  
    
    [statusView addSubview:indicator];
    
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 40)];
    [statusLabel setText:NSLocalizedString(@"service_status_legend", @"")];
    [statusLabel setFont:[UIFont fontWithName:@"GillSans" size:14]];
    [statusLabel setTextColor:[UIColor colorWithWhite:1 alpha:0.6]];
    [statusLabel setBackgroundColor:[UIColor clearColor]];
    
    statusValue = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, 80, 40)];
    [statusValue setBackgroundColor:[UIColor clearColor]];
    [statusValue setFont:[UIFont fontWithName:@"GillSans" size:14]];
    
    
    [statusView addSubview:statusLabel];
    [statusView addSubview:statusValue];
    
    [self.view addSubview:statusView];
}

- (void) drawStartControls
{
    start = [[UIButton alloc] initWithFrame:CGRectMake(0, [ApplicationConfig viewBounds].size.height-160, 110, 50)];
    [start setBackgroundColor:[UIColor blackColor]];
    [start.layer setShadowOffset:CGSizeMake(2, 2)];
    [start.layer setShadowOpacity:0.8];
    [start.layer setShadowRadius:2];
    [start.layer setShadowColor:[UIColor blackColor].CGColor];    
    
    startIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start.png"]];
    [startIcon setCenter:CGPointMake(22, 25)];
    [start addSubview:startIcon];
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 50)];
    [startLabel setText:NSLocalizedString(@"start_legend", @"Start legend")];
    [startLabel setTextColor:[UIColor whiteColor]];
    [startLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [startLabel setTextAlignment:UITextAlignmentRight];
    [startLabel setBackgroundColor:[UIColor clearColor]];
    [start addSubview:startLabel];
    
    [self.view addSubview:start];
    
    [start addTarget:self action:@selector(onStartButtonTap) forControlEvents:UIControlEventTouchUpInside];
}

- (void) viewDeckControllerDidOpenLeftView:(IIViewDeckController *)viewDeckController animated:(BOOL)animated
{
    if (!menuViewVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            startIcon.transform = CGAffineTransformRotate(startIcon.transform, -180*M_PI/180);
        }];
    }
    menuViewVisible = YES;
}

- (void) viewDeckControllerDidCloseLeftView:(IIViewDeckController *)viewDeckController animated:(BOOL)animated {
    if (menuViewVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            startIcon.transform = CGAffineTransformRotate(startIcon.transform, 180*M_PI/180);
        }];
    }
    menuViewVisible = NO;
}


- (void) onStartButtonTap
{
    [self.viewDeckController setCenterhiddenInteractivity:IIViewDeckCenterHiddenNotUserInteractiveWithTapToCloseBouncing];
    [self.viewDeckController toggleLeftViewAnimated:YES];  
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
