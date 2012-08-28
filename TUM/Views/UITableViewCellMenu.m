//
//  UITableViewCellMenu.m
//  TUM
//
//  Created by Alejandro on 13/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "UITableViewCellMenu.h"

#import "UIColor-Expanded.h"

@implementation UITableViewCellMenu

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(4, self.frame.size.height+5, self.frame.size.width-4, 1)];
        [separator setBackgroundColor:[UIColor colorWithHexString:@"0x3f4249"]];
        [self addSubview:separator];
        
        UIView *selectedView = [[UIView alloc] initWithFrame:self.frame];
        [selectedView setBackgroundColor:[UIColor colorWithHexString:@"0x626263"]];
        [self setSelectedBackgroundView:selectedView];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_2.png"]];
        [image setCenter:CGPointMake(self.frame.size.width-90, 25)];
        [self addSubview:image];
    }
    return self;
}

- (void) setTextLabel:(NSString *)textlabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 40)];
    [label setBackgroundColor:[UIColor clearColor]];
    
    [label setText:textlabel];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [label setTextAlignment:UITextAlignmentLeft];
    [label setTextColor:[UIColor colorWithHexString:@"0xadadad"]];
    [self.contentView addSubview:label];
}

@end

