//
//  HelpButton.m
//  TUM
//
//  Created by Alejandro on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpButton.h"
#import "ApplicationConfig.h"
#import <QuartzCore/QuartzCore.h>

#define dimension 200

@implementation HelpButton

- (id)init
{
    self = [self initWithFrame:CGRectMake([ApplicationConfig viewBounds].size.width/2-dimension/2, 140, dimension, dimension)];
    if (self) {
        [self.layer setCornerRadius:dimension/2];
        [self.layer setBackgroundColor:[UIColor colorWithRed:100 green:0 blue:0 alpha:0.6].CGColor];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setBorderColor:[UIColor redColor].CGColor];
        [self.layer setBorderWidth:5];
        [self.layer setShadowOpacity:1.7];
        [self setTitle:@"Auxilio" forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:35]];
        [self.titleLabel setShadowColor:[UIColor blackColor]];
        [self.titleLabel setShadowOffset:CGSizeMake(2, 2)];
        [self.titleLabel setTextColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8]];
    }
    return self;
}

@end
