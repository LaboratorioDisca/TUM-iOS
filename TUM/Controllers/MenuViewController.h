//
//  MenuViewController.h
//  TUM
//
//  Created by Alejandro on 13/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "UItableViewCellMenu.h"
#import "ControllerIconDelegate.h"

@interface MenuViewController : UITableViewController {
    NSArray *controllers;
}

@property (nonatomic, strong) NSArray *controllers;

- (id) initWithControllers:(NSArray*)newControllers;

@end
