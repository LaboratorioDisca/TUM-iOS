//
//  OverlayLegend.h
//  TUM
//
//  Created by Alejandro on 7/22/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LegendOverlay : UIView 

- (id) initWithFrame:(CGRect)frame forLanguage:(NSString*)lang;

- (void) hide;
- (void) show;

@end
