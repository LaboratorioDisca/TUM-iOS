//
//  OverlayLegend.m
//  TUM
//
//  Created by Alejandro on 7/22/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "LegendOverlay.h"

@implementation LegendOverlay

- (id)initWithFrame:(CGRect)frame withImageNamed:(NSString *)imageNamed
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setCornerRadius:4];
        [self.layer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setShadowOpacity:1.7];
        
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [tapRecognize setNumberOfTapsRequired:1];
        [self addGestureRecognizer:tapRecognize];
        
        [self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]]];
        [self hide];
    }
    return self;
}

- (void) hide
{
    [UIView animateWithDuration:0.8 animations:^{
        [self setAlpha:0.1];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
    }];
}

- (void) show
{
    [self setHidden:NO];
    [self setAlpha:0.1];
    [UIView animateWithDuration:0.6 animations:^{
        [self setAlpha:1];
    }];
}


@end
