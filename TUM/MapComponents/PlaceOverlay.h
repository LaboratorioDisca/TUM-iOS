//
//  PlaceOverlay.h
//  TUM
//
//  Created by Alejandro on 28/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationConfig.h"
#import "Place.h"

#define kPlaceOverlayHeight 80

@interface PlaceOverlay : UIView {
    UILabel *name;
    UILabel *categoryName;
}

- (id) initWithPlace:(Place*)place;
- (void) hide;

@end
