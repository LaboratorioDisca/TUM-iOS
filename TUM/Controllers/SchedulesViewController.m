//
//  SchedulesViewController.m
//  TUM
//
//  Created by Alejandro on 08/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "SchedulesViewController.h"

@interface SchedulesViewController () {
    UIView *container;
}

- (void) stylizeTitleLabel:(UILabel*)label withTranslationString:(NSString*)translationString;
- (void) stylizeContentLabel:(UILabel*)label withTranslationString:(NSString*)translationString;
@end

@implementation SchedulesViewController

- (id) init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
        [self setLeftButtonEnabled:YES];
        
        container = [[UIView alloc] initWithFrame:CGRectMake(-3, 100, [ApplicationConfig viewBounds].size.width+5, 300)];
        [container setBackgroundColor:[UIColor colorWithHexString:@"0x222526"]];
        [container.layer setBorderWidth:0.8];
        [container.layer setBorderColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.15].CGColor];
        [self.view addSubview:container];
        
        UILabel *weekdays = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 160, 30)];
        [self stylizeTitleLabel:weekdays withTranslationString:@"timetables_weekdays"];
        [container addSubview:weekdays];
        
        UILabel *weekdays_description = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 250, 30)];
        [self stylizeContentLabel:weekdays_description withTranslationString:@"timetables_weekdays_routes"];
        [container addSubview:weekdays_description];
        
        UILabel *saturdays = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 160, 30)];
        [self stylizeTitleLabel:saturdays withTranslationString:@"timetables_saturdays"];
        [container addSubview:saturdays];
        
        UILabel *saturdays_description = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 250, 30)];
        [self stylizeContentLabel:saturdays_description withTranslationString:@"timetables_saturdays_routes_one"];
        [container addSubview:saturdays_description];
        UILabel *saturdays_description_other = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 250, 30)];
        [self stylizeContentLabel:saturdays_description_other withTranslationString:@"timetables_saturdays_routes_two"];
        [container addSubview:saturdays_description_other];
        
        UILabel *sundays = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 250, 30)];
        [self stylizeTitleLabel:sundays withTranslationString:@"timetables_sundays"];
        [container addSubview:sundays];
        
        UILabel *sundays_description = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 250, 30)];
        [self stylizeContentLabel:sundays_description withTranslationString:@"timetables_sundays_routes"];
        [container addSubview:sundays_description];
        
        [self.view setClipsToBounds:YES];
    }
    return self;
}

- (void) stylizeTitleLabel:(UILabel*)label withTranslationString:(NSString*)translationString
{
    [label setText:NSLocalizedString(translationString, @"")];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
}

- (void) stylizeContentLabel:(UILabel*)label withTranslationString:(NSString*)translationString
{
    [label setText:NSLocalizedString(translationString, @"")];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:13]];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.viewDeckController setPanningMode:IIViewDeckFullViewPanning];
    [self.viewDeckController setRightController:nil];
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
