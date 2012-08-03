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

+ (void) overlayWithVehicleId:(NSString*)identifier withSpeed:(NSNumber*)speed withDate :(NSDate*)date forView:(UIView *)view
{
    if(currentOverlay == Nil) {
        currentOverlay = [[self alloc] initWithFrame:CGRectMake(0, 300, [ApplicationConfig viewBounds].size.width, 50)];
        [currentOverlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        
        UILabel *vehicle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 170, currentOverlay.frame.size.height-10)];
        [vehicle setText:@"VEHICULO"];
        
        [view addSubview:currentOverlay];
    }
    
    [currentOverlay setHumanizedDate:date];
    [[currentOverlay speedLabel] setText:[NSString stringWithFormat:@"%d km/h", speed]];
    [[currentOverlay identifierLabel] setText:identifier];
    
    [currentOverlay fadeIn];
    
    [currentOverlay performSelector:@selector(fadeOut) withObject:nil afterDelay:3];
    
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 20, 250, self.frame.size.height-40)];
        [speedLabel setFont:[UIFont systemFontOfSize:10]];
        [speedLabel setBackgroundColor:[UIColor clearColor]];
        [speedLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:speedLabel];
        
        identifierLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 170, self.frame.size.height-30)];
        [identifierLabel setFont:[UIFont systemFontOfSize:20]];
        [identifierLabel setBackgroundColor:[UIColor clearColor]];
        [identifierLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:identifierLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 10, 250, self.frame.size.height-10)];
        [dateLabel setFont:[UIFont systemFontOfSize:10]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:dateLabel];
    }
    return self;
}

- (void) setHumanizedDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];
    [dateFormatter setLocale:locale];
    [dateFormatter setDoesRelativeDateFormatting:YES];
        
    [[self dateLabel] setText:[dateFormatter stringFromDate:date]];
}

- (void) fadeIn
{
    [UIView animateWithDuration:2 animations:^{
        [self setAlpha:1];
    } completion:^(BOOL finished) {
        [self setHidden:NO];
    }];
}

- (void) fadeOut
{
    [UIView animateWithDuration:2 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}

@end
