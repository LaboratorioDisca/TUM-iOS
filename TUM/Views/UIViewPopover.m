//
//  UIViewPopover.m
//  TUM
//
//  Created by Alejandro on 24/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "UIViewPopover.h"

@interface UIViewPopover ()
- (void) addIconsForItems:(NSArray*)items;
- (void) increaseButtonBright:(id)button;
- (void) restoreButtonBright:(id)button;
- (void) routesSelected;
- (void) placesSelected;
- (void) bookLegendSelected;

@end

@implementation UIViewPopover

@synthesize delegate;

- (id) initOnRightPositionWithItems:(NSArray *)items
{
    CGRect dimensions = CGRectMake([ApplicationConfig viewBounds].size.width-kWidth-kMarignLeft, kMarginTop, kWidth, kHeight);
    self = [super initWithFrame:dimensions];
    if (self) {
        [self.layer setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"assault"]].CGColor];
        [self.layer setBorderWidth:4];
        [self.layer setCornerRadius:4];
        [self.layer setShadowOpacity:2];
        [self.layer setShadowOffset:CGSizeMake(2, 1)];
        [self.layer setBorderColor:[UIColor colorWithHexString:@"0x0E223D"].CGColor];
                
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_up"]];
        [imageView setCenter:CGPointMake(self.frame.size.width-20, -7)];
        [self addSubview:imageView];
        
        [self bringSubviewToFront:imageView];
        [self addIconsForItems:items];
        
    }
    return self;
}

- (void) addIconsForItems:(NSArray *)items
{
    int yIncrement = 50;
    int yPos = 10;
    int xPos = 10;
    for (NSString *item in items) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(xPos, yPos, kWidth-20, 40)];
        [button setBackgroundColor:[UIColor colorWithHexString:@"0x2F3030"]];
        [button.layer setCornerRadius:5];
        [button.layer setShadowOpacity:2];
        [button.layer setShadowOffset:CGSizeMake(1, 1)];
        [button.titleLabel setText:item];
        
        [button addTarget:self action:@selector(increaseButtonBright:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(restoreButtonBright:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel|UIControlEventTouchDragOutside];
        [button addTarget:self action:NSSelectorFromString([item stringByAppendingString:@"Selected"]) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, kWidth-60, 30)];
        [label setText:NSLocalizedString(item, @"Item Section")];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor colorWithHexString:@"0xB9BEBF"]];
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [button addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item]];
        [imageView setCenter:CGPointMake(25,20)];
        [button addSubview:imageView];
        [self addSubview:button];
        
        yPos = yPos+yIncrement;
    }
}

- (void) disappearAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            [self setAlpha:0];
            for (UIButton *button in [self subviews]) {
                [button setAlpha:0];
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
        }];
    } else {
        [self removeFromSuperview];
    }
}

- (void) appearAnimated:(BOOL)animated
{
    [self setAlpha:0];
    [self.delegate clearViewForPopover];
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            [self setAlpha:1];
            for (UIButton *button in [self subviews]) {
                [button setAlpha:1];
            }
        }];
    } else {
        [self setAlpha:1];
        for (UIButton *button in [self subviews]) {
            [button setAlpha:1];
        }
    }
}

- (void) increaseButtonBright:(id)button
{
    //[button setBackgroundColor:[UIColor colorWithHexString:@"0D2942"]];
    [button setBackgroundColor:[UIColor colorWithHexString:@"0x464747"]];

}

- (void) restoreButtonBright:(id)button
{
    [button setBackgroundColor:[UIColor colorWithHexString:@"2F3030"]];
}

- (void) routesSelected
{
    [self.delegate reactToPopoverItemSelectedWith:1];
    [self disappearAnimated:NO];
}

- (void) placesSelected
{
    [self.delegate reactToPopoverItemSelectedWith:2];
    [self disappearAnimated:NO];
}

- (void) bookLegendSelected
{
    [self.delegate reactToPopoverItemSelectedWith:3];
    [self disappearAnimated:NO];
}



@end
