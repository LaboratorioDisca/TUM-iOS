//
//  UITableViewCellForPlaceRow.m
//  TUM
//
//  Created by Alejandro on 27/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "UITableViewCellForPlaceRow.h"

@interface UITableViewCellForPlaceRow() {
}

- (void) applyStyleToLabel:(UILabel*)label withFontSize:(int) size;

@end

@implementation UITableViewCellForPlaceRow

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier forPlace:(Place *)place
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 300, 20)];
        [name setText:place.name];
        [self applyStyleToLabel:name withFontSize:18];
        
        UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(30, 45, 300, 20)];
        [type setText:[place placeCategory].uppercaseString];
        [self applyStyleToLabel:type withFontSize:10];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(4, self.frame.size.height+35, self.frame.size.width-10, 0.5)];
        [separator setBackgroundColor:[UIColor colorWithHexString:@"0x3f4249"]];
        [self addSubview:separator];
        
        
        UIView *selectedView = [[UIView alloc] initWithFrame:self.frame];
        [selectedView setBackgroundColor:[UIColor colorWithRed:11 green:27 blue:48 alpha:0.2]];
        [self setSelectedBackgroundView:selectedView];
    }
    return self;
}

- (void) applyStyleToLabel:(UILabel *)label withFontSize:(int)size
{
    
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor colorWithHexString:@"0xC4C4C4"]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:size]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setShadowColor:[UIColor blackColor]];
    [label setShadowOffset:CGSizeMake(1, 2)];
    [self.contentView addSubview:label];
}

@end
