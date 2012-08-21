//
//  AppDelegate.m
//  TUM
//
//  Created by Alejandro on 20/04/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize controllerManager;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [RoutesViewController controller];
    
    [Stations loadStationsFromFile];
    
    MapViewController *map = [[MapViewController alloc] init];
    map.title = NSLocalizedString(@"map", @"");
    [map.tabBarItem setImage:[UIImage imageNamed:@"map.png"]];
    
    ReportsViewController *reports = [[ReportsViewController alloc]  init];
    reports.title = NSLocalizedString(@"report", @"");
    [reports.tabBarItem setImage:[UIImage imageNamed:@"alert.png"]];

    FrontViewController *home = [[FrontViewController alloc] init];
    home.title = NSLocalizedString(@"home", @"");
    [home.tabBarItem setImage:[UIImage imageNamed:@"home.png"]];
    
    HelpViewController *help = [[HelpViewController alloc] init];
    help.title = NSLocalizedString(@"help", @"");
    [help.tabBarItem setImage:[UIImage imageNamed:@"info.png"]];
    
    SchedulesViewController *schedules = [[SchedulesViewController alloc] init];
    schedules.title =NSLocalizedString(@"schedules", @"");
    [schedules.tabBarItem setImage:[UIImage imageNamed:@"info.png"]];
    
    //[tabBarController setViewControllers:[NSArray arrayWithObjects:home, map, routes, help, schedules, nil] animated:YES];

    
    MenuViewController *menu = [[MenuViewController alloc] initWithControllers:[NSArray arrayWithObjects:home, map, help, schedules, nil]];
    controllerManager = [[IIViewDeckController alloc] initWithCenterViewController:home 
                                                                leftViewController:menu 
                                                               rightViewController:nil];
    [self.window setRootViewController:controllerManager];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
