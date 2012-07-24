//
//  OverlayLegend.h
//  TUM
//
//  Created by Alejandro on 7/22/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ActionButton.h"
#import "OvermapButton.h"

@interface OverlayLegend : UIView {
    id<ActionButton> delegate;
}

@property (nonatomic, strong) id<ActionButton> delegate;

- (id) initWithFrame:(CGRect)frame withImageNamed:(NSString*)imageNamed;

- (void) hide;
- (void) show;

@end
