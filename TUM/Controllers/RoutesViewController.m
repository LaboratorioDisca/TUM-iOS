//
//  RoutesViewController.m
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoutesViewController.h"
#import "Routes.h"
#import "Route.h"
#import "UITableViewCellForRouteRow.h"

@interface RoutesViewController() {
    NSArray *cachedRoutes;
}
@property (nonatomic, retain) NSArray *cachedRoutes; 

@end

@implementation RoutesViewController
@synthesize cachedRoutes;

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.cachedRoutes.count; 
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    Route* route = [cachedRoutes objectAtIndex:indexPath.row];
    UITableViewCellForRouteRow *cell = [[UITableViewCellForRouteRow alloc] init];
    [cell drawRouteDataWith:route];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Route* route = [cachedRoutes objectAtIndex:indexPath.row];
    if ([route visibleOnMap]) {
        [route setVisibleOnMap:NO];
    } else {
        [route setVisibleOnMap:YES];
    }
    [self.tableView reloadData];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    cachedRoutes = [[Routes currentCollection] sortedCollection];
    self.navigationItem.title = @"Rutas";
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"linen.png"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
