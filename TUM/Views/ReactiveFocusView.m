//
//  ReactiveFocusView.m
//  TUM
//
//  Created by Alejandro on 24/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "ReactiveFocusView.h"

@implementation ReactiveFocusView
@synthesize delegate;

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([[event touchesForView:delegate] count] == 0) {
        [delegate disappearAnimated:YES];
        return NO;
    } 
    
    return YES;
}

@end
