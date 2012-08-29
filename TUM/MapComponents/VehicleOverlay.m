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

@synthesize speedLabel, identifierLabel, dateLabel, defaultImage, annotation;

+ (id) overlayForAnnotation:(VehicleAnnotation *)annotation
{
    VehicleOverlay *overlay = [[self alloc] initWithFrame:CGRectMake(0, 45, [ApplicationConfig viewBounds].size.width, 55) 
                                    withVehicleAnnotation:annotation];
    
    UIView *banFlag = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 5)];
    [banFlag setBackgroundColor:[UIColor colorWithHexString:[annotation.route color]]];
    [overlay addSubview:banFlag];
    
    [overlay setHumanizedDate:[annotation.instant date]];
    [[overlay speedLabel] setText:[NSString stringWithFormat:[NSLocalizedString(@"speed", @"") 
                                                                     stringByAppendingString:@" %d km/h"], [[annotation.instant vehicleSpeed] intValue]]];
    Vehicle *vehicle = [Vehicles getVehicleById:annotation.instant.vehicleId];
    [[overlay identifierLabel] setText:[vehicle vehicleNumber]];
    
    [annotation markAsSelected];
    return overlay;
}

- (void) destroy
{
    [annotation markAsDeselected];
    [self removeFromSuperview];
}

- (id) initWithFrame:(CGRect)frame withVehicleAnnotation:(VehicleAnnotation*)annotation_
{
    self = [super initWithFrame:frame];
    if (self) {
        annotation = annotation_;
        UILabel *vehicle = [[UILabel alloc] initWithFrame:CGRectMake(20, -5, 170, self.frame.size.height-10)];
        [vehicle setText:NSLocalizedString(@"vehicle", @"")];
        [vehicle setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [vehicle setTextColor:[UIColor whiteColor]];
        
        [vehicle setBackgroundColor:[UIColor clearColor]];
        [self addSubview:vehicle];
        
        identifierLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 22, 170, self.frame.size.height-30)];
        [identifierLabel setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:18]];
        [identifierLabel setBackgroundColor:[UIColor clearColor]];
        [identifierLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:identifierLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, -5, 180, self.frame.size.height-10)];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];

        [self addSubview:dateLabel];
        
        speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 24, 180, self.frame.size.height-30)];
        [speedLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [speedLabel setBackgroundColor:[UIColor clearColor]];
        [speedLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:speedLabel];
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setShadowOpacity:1.7];
        


    }
    return self;
}

- (void) wireDestroyActionTo:(id)object
{
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake([ApplicationConfig viewBounds].size.width-50, 10, 35, 35)];
    [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:object action:@selector(destroyVehicleOverlay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
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

- (NSNumber*) associatedVehicleId
{
    return [NSNumber numberWithInt:1];
    //return [annotation.userInfo instant].vehicleId;
}

- (void) resetToDefaultIcon
{
    //[annotation.userInfo resetToDefaultImage];
}

- (CLLocationCoordinate2D) associatedVehicleCoordinate
{
    return CLLocationCoordinate2DMake(-99.2232, 19.232);
    //return [[annotation.userInfo instant] coordinates];
}

@end
