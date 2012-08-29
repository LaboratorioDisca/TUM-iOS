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

}

@end

@implementation AboutViewController

- (id) init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
        [self setLeftButtonEnabled:YES];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, [ApplicationConfig viewBounds].size.width, 30)];
        [label setText:NSLocalizedString(@"developed_by", @"")];
        [label setTextColor:[UIColor whiteColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [label setTextAlignment:UITextAlignmentCenter];
        [self.view addSubview:label];
        
        UIView *borderTop = [[UIView alloc] initWithFrame:CGRectMake(0, 119, [ApplicationConfig viewBounds].size.width, 1)];
        [borderTop setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.15]];
        [self.view addSubview:borderTop];
        
        scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 120, [ApplicationConfig viewBounds].size.width, 280);
        scrollView.contentSize = CGSizeMake([ApplicationConfig viewBounds].size.width * kPages, 280);
        [scrollView setPagingEnabled:YES];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:scrollView];
        [scrollView setDelegate:self];
        /*[scrollView.layer setBorderWidth:0.8];
        [scrollView.layer setBorderColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.15].CGColor];
        */
        
        UIView *borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 400, [ApplicationConfig viewBounds].size.width, 1)];
        [borderBottom setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.15]];
        [self.view addSubview:borderBottom];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, [ApplicationConfig viewBounds].size.width, 40)];
        [self.view addSubview:pageControl];
        [pageControl setNumberOfPages:kPages];
        
        [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];

        /*[pageControl setBackgroundColor:];
        
        
        */
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

@end
