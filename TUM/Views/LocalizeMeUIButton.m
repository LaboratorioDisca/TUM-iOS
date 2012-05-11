//
//  LocalizeMeUIButton.m
//  TUM
//
//  Created by Alejandro on 07/05/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "LocalizeMeUIButton.h"
#import "ApplicationConfig.h"
#import <QuartzCore/QuartzCore.h>

#define dimension 40

@implementation LocalizeMeUIButton

- (id) init
{
    self = [super initWithFrame:CGRectMake([ApplicationConfig viewBounds].size.width-30-dimension/2, 20, dimension, dimension)];
    if (self) {
        [self.layer setCornerRadius:dimension/2];
        [self.layer setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5].CGColor];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setShadowOpacity:1.7];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"localize.png"]];
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
                         self.transform = CGAffineTransformRotate(self.transform, 45);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.8
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.transform = CGAffineTransformRotate(self.transform, -45);
                                              [self.layer setOpacity:1];
                                          } completion:nil];
                     }];
}

@end
