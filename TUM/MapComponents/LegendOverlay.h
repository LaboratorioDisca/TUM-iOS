//
//  OverlayLegend.h
//  TUM
//
//  Created by Alejandro on 7/22/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ToggleButton.h"
#import "OvermapButton.h"

@interface LegendOverlay : UIView {
    id<ToggleButton> delegate;
}

@property (nonatomic, strong) id<ToggleButton> delegate;

- (id) initWithFrame:(CGRect)frame withImageNamed:(NSString*)imageNamed;

- (void) hide;
- (void) show;

@end
