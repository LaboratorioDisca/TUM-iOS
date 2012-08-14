//
//  UITableViewCellForRouteRow.m
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "UITableViewCellForRouteRow.h"
#import "UIColor-Expanded.h"
#import <QuartzCore/QuartzCore.h>

#define kLeftMargin 100
@interface UITableViewCellForRouteRow() {
}

- (void) applyStyleToDirectionLabel:(UILabel*)label;

@end

@implementation UITableViewCellForRouteRow

- (void) drawRouteDataWith:(Route *)route
{
    NSString *routeNumber = [[route name] stringByReplacingOccurrencesOfString:@"Ruta " withString:@""];
    UILabel *routeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin*2+40, 20, 60, 60)];

    [routeLabel setText:routeNumber];
    [routeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:50]];
    [routeLabel setTextAlignment:UITextAlignmentCenter];
    [routeLabel setBackgroundColor:[UIColor clearColor]];
    [routeLabel setShadowColor:[UIColor blackColor]];
    [routeLabel setShadowOffset:CGSizeMake(-1, 3)];
    [self.contentView addSubview:routeLabel];
    
    
    
    UILabel *leftDirectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin-40, 35, 300, 20)];
    [leftDirectionLabel setText:route.leftTerminal];
    [self applyStyleToDirectionLabel:leftDirectionLabel];

    UILabel *rightDirectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftMargin-40, 50, 300, 20)];
    [rightDirectionLabel setText:route.rightTerminal];
    [self applyStyleToDirectionLabel:rightDirectionLabel];
    
    
    UIView *topSeparator = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 8)];
    [topSeparator setBackgroundColor:[UIColor colorWithHexString:route.color]];
    [topSeparator.layer setShadowOffset:CGSizeMake(1, 3)];
    [topSeparator.layer setShadowOpacity:0.5];
    [topSeparator.layer setShadowRadius:1.3];
    [topSeparator.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.contentView addSubview:topSeparator];
    
    if ([route visibleOnMap]) {
        [routeLabel setTextColor:[UIColor whiteColor]];
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"0x333333"]];
    } else {
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"0x1C1C1C"]];
        [routeLabel setTextColor:[UIColor colorWithHexString:@"0x2E2E2E"]];
    }
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void) applyStyleToDirectionLabel:(UILabel *)label
{
    int directionsFontSize=11;

    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor colorWithHexString:@"0x999999"]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:directionsFontSize]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setShadowColor:[UIColor blackColor]];
    [label setShadowOffset:CGSizeMake(1, 2)];
    [self.contentView addSubview:label];
}

@end
