//
//  AboutViewController.m
//  TUM
//
//  Created by Alejandro on 28/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController () {
    UIView *container;
    UIPageControl *pageControl;
    UIScrollView* scrollView;

    UIImageView *panel;
    UIView *diffuseView;
    UIButton *plusInfo;
}

- (void) showMoreInfo;
- (void) hideMoreInfo;
- (void) increaseButtonBright:(id)button;
- (void) restoreButtonBright:(id)button;

@end

@implementation AboutViewController

- (id) init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
        [self setLeftButtonEnabled:YES];
        
        UILabel *mainText = [[UILabel alloc] initWithFrame:CGRectMake(45, 60, 150, 50)];
        [mainText setNumberOfLines:3];
        [mainText setText:NSLocalizedString(@"about_main", @"")];
        [mainText setTextColor:[UIColor colorWithHexString:@"0x63635F"]];
        [mainText setBackgroundColor:[UIColor clearColor]];
        [mainText setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [self.view addSubview:mainText];
        
        plusInfo = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusInfo setFrame:CGRectMake(230, 70, 70, 30)];
        [plusInfo setTitle:NSLocalizedString(@"plus_info", @"") forState:UIControlStateNormal];
        [plusInfo.titleLabel setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:14]];
        [plusInfo.titleLabel setShadowOffset:CGSizeMake(0.5, 0.5)];
        [plusInfo.layer setShadowOffset:CGSizeMake(1, 1)];
        [plusInfo.layer setShadowOpacity:0.5];
        [plusInfo.layer setCornerRadius:7];
        [plusInfo.layer setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.6].CGColor];
        [plusInfo.layer setBorderColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8].CGColor];
        [plusInfo.layer setBorderWidth:1],
        [plusInfo addTarget:self action:@selector(showMoreInfo) forControlEvents:UIControlEventTouchUpInside];
        [plusInfo addTarget:self action:@selector(increaseButtonBright:) forControlEvents:UIControlEventTouchDown];
        [plusInfo addTarget:self action:@selector(restoreButtonBright:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel|UIControlEventTouchDragOutside];
        [self.view addSubview:plusInfo];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, [ApplicationConfig viewBounds].size.width, 30)];
        [label setText:NSLocalizedString(@"developed_by", @"")];
        [label setTextColor:[UIColor colorWithHexString:@"0x63635F"]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:15]];
        [label setTextAlignment:UITextAlignmentCenter];
        [self.view addSubview:label];
        
        UIView *borderTop = [[UIView alloc] initWithFrame:CGRectMake(0, 159, [ApplicationConfig viewBounds].size.width, 1)];
        [borderTop setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.15]];
        [self.view addSubview:borderTop];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 160, [ApplicationConfig viewBounds].size.width, 260)];
        scrollView.contentSize = CGSizeMake([ApplicationConfig viewBounds].size.width * kPages, 260);
        [scrollView setPagingEnabled:YES];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:scrollView];
        [scrollView setDelegate:self];
        /*[scrollView.layer setBorderWidth:0.8];
        [scrollView.layer setBorderColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.15].CGColor];
        */
        
        UIView *borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 420, [ApplicationConfig viewBounds].size.width, 1)];
        [borderBottom setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.15]];
        [self.view addSubview:borderBottom];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 422, [ApplicationConfig viewBounds].size.width, 40)];
        [self.view addSubview:pageControl];
        [pageControl setNumberOfPages:kPages];
        
        [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
        
        UITapGestureRecognizer *gestureRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMoreInfo)];
        [gestureRecog setNumberOfTouchesRequired:1];
        [gestureRecog setNumberOfTapsRequired:1];
        
        diffuseView = [[UIView alloc] initWithFrame:[ApplicationConfig viewBounds]];
        [diffuseView setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.7]];
        [self.view addSubview:diffuseView];
        [diffuseView setHidden:YES];
        
        panel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"white_dialog.png"]];
        [panel setFrame:CGRectMake(30, 80, panel.frame.size.width, panel.frame.size.height)];
        [diffuseView addSubview:panel];
        [panel addGestureRecognizer:gestureRecog];
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    pageControl.currentPage = 0;
    
    NSArray *array = [NSArray arrayWithObjects:@"0x222526", @"0x49d32", @"0x482dd", nil];
    for (int i = 0; i < array.count; i++) {
        CGRect frame;
        frame.origin.x = scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [UIColor colorWithHexString:[array objectAtIndex:i]];
        [scrollView addSubview:subview];
    }
    [self.viewDeckController setRightController:nil];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    [scrollView removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) onLeftControlActivate
{
    [self.viewDeckController openLeftView];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
}

- (void) pageChanged
{
    CGRect frame;
    frame.origin.x = scrollView.frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = scrollView.frame.size;
    [scrollView scrollRectToVisible:frame animated:YES];
}
         
- (void) showMoreInfo
{
    [plusInfo setHidden:YES];
    [diffuseView setHidden:NO];
}

- (void) hideMoreInfo
{
    [diffuseView removeFromSuperview];

    [panel setHidden:YES];
}

- (void) increaseButtonBright:(id)button
{
    [[button layer] setShadowOpacity:0.8];
    [[button layer] setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8].CGColor];
    [[button layer] setBorderColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.9].CGColor];  

}

- (void) restoreButtonBright:(id)button
{
    [[button layer] setShadowOpacity:0.5];
    [[button layer] setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.6].CGColor];
    [[button layer] setBorderColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8].CGColor];    
    [[button titleLabel] setTextColor:[UIColor whiteColor]];

}

@end
