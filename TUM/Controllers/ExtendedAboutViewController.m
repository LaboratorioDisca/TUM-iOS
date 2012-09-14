//
//  ExtendedAboutViewController.m
//  TUM
//
//  Created by Alejandro Cruz Paz on 9/13/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "ExtendedAboutViewController.h"

@interface ExtendedAboutViewController ()

@end

@implementation ExtendedAboutViewController

- (id) init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"more_info", @"");
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
        [self setLeftButtonEnabled:NO];
        
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close_navbar.png"]];
        [rightButton addSubview:imgView];
        [rightButton setFrame:CGRectMake(280, 0, 40, 40)];
        [imgView setCenter:CGPointMake(15, 22)];

        [navigationBar addSubview:rightButton];
        [rightButton addTarget:self action:@selector(onRightControlActivate) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *disclaimer_beta = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, [ApplicationConfig viewBounds].size.width-40, 100)];
        [disclaimer_beta setText:NSLocalizedString(@"disclaimer_beta", @"")];
        [disclaimer_beta setTextColor:[UIColor colorWithHexString:@"0xA8A8A8"]];
        [disclaimer_beta setBackgroundColor:[UIColor clearColor]];
        [disclaimer_beta setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:16]];
        [disclaimer_beta setTextAlignment:UITextAlignmentLeft];
        [disclaimer_beta setNumberOfLines:4];
        [disclaimer_beta setLineBreakMode:UILineBreakModeTailTruncation];
        
        [self.view addSubview:disclaimer_beta];
        
        UILabel *disclaimer = [[UILabel alloc] initWithFrame:CGRectMake(20, 155, [ApplicationConfig viewBounds].size.width-40, 100)];
        [disclaimer setText:NSLocalizedString(@"disclaimer", @"")];
        [disclaimer setTextColor:[UIColor colorWithHexString:@"0x63635F"]];
        [disclaimer setBackgroundColor:[UIColor clearColor]];
        [disclaimer setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:14]];
        [disclaimer setTextAlignment:UITextAlignmentLeft];
        [disclaimer setLineBreakMode:UILineBreakModeTailTruncation];
        [disclaimer setNumberOfLines:5];
        [self.view addSubview:disclaimer];
        
        UIView *decorator = [[UIView alloc] initWithFrame:CGRectMake(10, 280, [ApplicationConfig viewBounds].size.width-20, 1)];
        [decorator setBackgroundColor:[UIColor colorWithHexString:@"0x3D3D3D"]];
        [self.view addSubview:decorator];
        
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pumabus_project.png"]];
        [logo setCenter:CGPointMake([ApplicationConfig viewBounds].size.width/2, 335)];
        [self.view addSubview:logo];
        
        UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(20, 370, [ApplicationConfig viewBounds].size.width-40, 40)];
        [version setText:NSLocalizedString(@"app_version", @"")];
        [version setTextColor:[UIColor colorWithHexString:@"0xB86F13"]];
        [version setBackgroundColor:[UIColor clearColor]];
        [version setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:14]];
        [version setTextAlignment:UITextAlignmentCenter];
        [self.view addSubview:version];
        
        UILabel *url = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, [ApplicationConfig viewBounds].size.width-40, 40)];
        [url setText:@"http://app-pumabus.unam.mx"];
        [url setTextColor:[UIColor colorWithHexString:@"0xA8A8A8"]];
        [url setBackgroundColor:[UIColor clearColor]];
        [url setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:17]];
        [url setTextAlignment:UITextAlignmentCenter];
        [self.view addSubview:url];
    }
    return self;
}

- (void) onRightControlActivate
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
