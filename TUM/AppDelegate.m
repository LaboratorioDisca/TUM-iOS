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
@synthesize window = _window, memoryWarningReceived;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [RoutesViewController controller];
    
    [Places loadStationsFromFile];
    
    
    // load tiles from SQLlite db
    NSURL *tilesURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"UNAMCU" 
                                                                             ofType:@"mbtiles"]];    
    map = [[MapViewController alloc] initWithTileSource:
                              [[RMMBTilesSource alloc] initWithTileSetURL:tilesURL]];
    map.title = NSLocalizedString(@"map", @"");
    
    ReportsViewController *reports = [[ReportsViewController alloc]  init];
    reports.title = NSLocalizedString(@"report", @"");

    FrontViewController *home = [[FrontViewController alloc] init];
    home.title = NSLocalizedString(@"home", @"");
    
    /*HelpViewController *help = [[HelpViewController alloc] init];
    help.title = NSLocalizedString(@"help", @"");
    [help.tabBarItem setImage:[UIImage imageNamed:@"info.png"]];*/
    
    SchedulesViewController *schedules = [[SchedulesViewController alloc] init];
    schedules.title =NSLocalizedString(@"schedules", @"");
    
    //[tabBarController setViewControllers:[NSArray arrayWithObjects:home, map, routes, help, schedules, nil] animated:YES];
    AboutViewController *about = [[AboutViewController alloc] init];
    about.title = NSLocalizedString(@"about", @"");
    
    MenuViewController *menu = [[MenuViewController alloc] initWithControllers:[NSArray arrayWithObjects:home, map, schedules, about, nil]];
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
    if (memoryWarningReceived) {
        // load tiles from SQLlite db
        NSURL *tilesURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"UNAMCU" 
                                                                                 ofType:@"mbtiles"]];    
        map = [[MapViewController alloc] initWithTileSource:
               [[RMMBTilesSource alloc] initWithTileSetURL:tilesURL]];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [self setMemoryWarningReceived:YES];
}

@end
