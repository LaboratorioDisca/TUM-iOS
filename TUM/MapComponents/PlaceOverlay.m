//
//  PlaceOverlay.m
//  TUM
//
//  Created by Alejandro on 28/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "PlaceOverlay.h"

@implementation PlaceOverlay

- (id) initWithPlace:(Place *)place
{
    self = [super initWithFrame:CGRectMake(0, [ApplicationConfig viewBounds].size.height-kPlaceOverlayHeight, [ApplicationConfig viewBounds].size.width, kPlaceOverlayHeight)];
    if (self) {
        name = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [ApplicationConfig viewBounds].size.width, kPlaceOverlayHeight/2)];
        [name setBackgroundColor:[UIColor clearColor]];
        [name setTextColor:[UIColor whiteColor]];
        [name setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:18]];
        [name setText:place.name];
        [self addSubview:name];
        
        categoryName = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, [ApplicationConfig viewBounds].size.width, kPlaceOverlayHeight/2)];
        [categoryName setBackgroundColor:[UIColor clearColor]];
        [categoryName setTextColor:[UIColor whiteColor]];
        [categoryName setFont:[UIFont fontWithName:[ApplicationConfig defaultFont] size:11]];
        [categoryName setText:place.placeCategory.uppercaseString];
        [self addSubview:categoryName];
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake([ApplicationConfig viewBounds].size.width-50, 15, 35, 35)];
        [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
    }
    return self;
}

- (void) hide
{
    [self removeFromSuperview];
}

@end
