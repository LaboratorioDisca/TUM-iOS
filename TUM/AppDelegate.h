//
//  AppDelegate.h
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "RoutesViewController.h"
#import "FrontViewController.h"
#import "ReportsViewController.h"
#import "Instants.h"
#import "HelpViewController.h"
#import "SchedulesViewController.h"
#import "MenuViewController.h"
#import "AboutViewController.h"
#import "IIViewDeckController.h"
#import "Places.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BOOL memoryWarningReceived;
    MapViewController *map;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IIViewDeckController *controllerManager;
@property (nonatomic, assign) BOOL memoryWarningReceived;

@end
