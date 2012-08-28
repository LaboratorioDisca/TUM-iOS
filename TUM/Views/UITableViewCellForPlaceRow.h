//
//  UITableViewCellForPlaceRow.h
//  TUM
//
//  Created by Alejandro on 27/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "UIColor-Expanded.h"
#import <QuartzCore/QuartzCore.h>

@interface UITableViewCellForPlaceRow : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier forPlace:(Place*)place;

@end
