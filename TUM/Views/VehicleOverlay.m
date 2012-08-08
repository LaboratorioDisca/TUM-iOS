//
//  VehicleOverlay.m
//  TUM
//
//  Created by Alejandro on 03/08/12.
//  Copyright (c) 2012  UNAM IIMAS Disca. All rights reserved.
//

#import "VehicleOverlay.h"

@interface VehicleOverlay() 
- (void) setHumanizedDate:(NSDate*)date;
@end

@implementation VehicleOverlay

static VehicleOverlay* currentOverlay;
@synthesize speedLabel, identifierLabel, dateLabel;

+ (void) overlayWithVehicleId:(NSString*)identifier withSpeed:(NSNumber*)speed withDate :(NSDate*)date withColor:(NSString*)color forView:(UIView *)view
{
    if(currentOverlay != nil) {
        [VehicleOverlay destroy];
    }
    
    currentOverlay = [[self alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 55)];
    [view addSubview:currentOverlay];

    UIView *banFlag = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 5)];
    [banFlag setBackgroundColor:[UIColor colorWithHexString:color]];
    [currentOverlay addSubview:banFlag];
    
    [currentOverlay setHumanizedDate:date];
    [[currentOverlay speedLabel] setText:[NSString stringWithFormat:[NSLocalizedString(@"speed", @"") stringByAppendingString:@" %d km/h"], [speed intValue]]];
    [[currentOverlay identifierLabel] setText:identifier];
    
    [currentOverlay fadeIn];
}

+ (VehicleOverlay*) current
{
    return currentOverlay;
}

+ (void) destroy
{
    [currentOverlay removeFromSuperview];
    currentOverlay = nil;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *vehicle = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 170, self.frame.size.height-10)];
        [vehicle setText:NSLocalizedString(@"vehicle", @"")];
        [vehicle setFont:[UIFont fontWithName:@"GillSans" size:12]];
        [vehicle setTextColor:[UIColor whiteColor]];
        
        [vehicle setBackgroundColor:[UIColor clearColor]];
        [self addSubview:vehicle];
        
        identifierLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 22, 170, self.frame.size.height-30)];
        [identifierLabel setFont:[UIFont fontWithName:@"GillSans-Bold" size:18]];
        [identifierLabel setBackgroundColor:[UIColor clearColor]];
        [identifierLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:identifierLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, -5, 180, self.frame.size.height-10)];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setFont:[UIFont fontWithName:@"GillSans" size:14]];

        [self addSubview:dateLabel];
        
        speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 24, 180, self.frame.size.height-30)];
        [speedLabel setFont:[UIFont fontWithName:@"GillSans" size:14]];
        [speedLabel setBackgroundColor:[UIColor clearColor]];
        [speedLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:speedLabel];
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setShadowOpacity:1.7];
        
        UITapGestureRecognizer *tapToHide = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(fadeOut)];
        [self addGestureRecognizer:tapToHide];
    }
    return self;
}

- (void) setHumanizedDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];
    [dateFormatter setLocale:locale];
    [dateFormatter setDoesRelativeDateFormatting:YES];
        
    [[self dateLabel] setText:[dateFormatter stringFromDate:date]];
}

- (void) fadeIn
{
    [self setAlpha:1];
    [self setHidden:NO];
}

- (void) fadeOut
{
    [UIView animateWithDuration:1 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}

@end
