//
//  OvermapButton.m
//  TUM
//
//  Created by Alejandro on 07/05/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "OvermapButton.h"

#define dimension 30

@implementation OvermapButton

- (id) initWithImageNamed:(NSString *)imageName
{
    self = [super initWithFrame:CGRectMake([ApplicationConfig viewBounds].size.width-30-dimension/2, [ApplicationConfig viewBounds].size.height-60, dimension, dimension)];
    if (self) {
        [self.layer setCornerRadius:4];
        [self.layer setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8].CGColor];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setShadowOpacity:1.7];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [image setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:image];
    }
    return self;
}

- (void) blink 
{
    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.layer setOpacity:0.4];
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.8
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              [self.layer setOpacity:0.8];
                                          } completion:nil];
                     }];
}

- (void) show
{
    [self setHidden:NO];
}

- (void) hide
{
    [self setHidden:YES];
}

@end
