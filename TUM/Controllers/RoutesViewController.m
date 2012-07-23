//
//  RoutesViewController.m
//  TUM
//
//  Created by Alejandro on 5/5/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "RoutesViewController.h"
#import "Routes.h"
#import "Route.h"
#import "UITableViewCellForRouteRow.h"
#import "ApplicationConfig.h"
#import "UIColor-Expanded.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@interface RoutesViewController() {
    NSArray *cachedRoutes;
}
@property (nonatomic, retain) NSArray *cachedRoutes; 

- (void) configureToolbar;

@end

@implementation RoutesViewController
@synthesize cachedRoutes;

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self fetchRoutes];
    }
    return self;
}

/* Start requests section */

- (void) fetchRoutes
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[ApplicationConfig urlForResource:@"routes"]]];
    [request setDelegate:self];
    [request startAsynchronous];
} 

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *routes = [request responseString];
    // Insert the recently loaded data from Backend
    [Routes loadWithRoutesCollection:[routes JSONValue]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error;

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"routes" ofType:@"json"]; 
    NSString *routes = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    [Routes loadWithRoutesCollection:[routes JSONValue]];
}

/* End requests section */



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

- (void) configureToolbar
{
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 11.0f, self.view.frame.size.width, 21.0f)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0]];
    [titleLabel setText:@"Rutas"];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];

    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, 40)];
    [toolbar setTintColor:[UIColor blackColor]];
    [self.tableView setTableHeaderView:toolbar];
    [toolbar setItems:[NSArray arrayWithObjects:spacer, title, spacer2, nil] animated:YES];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    cachedRoutes = [[Routes currentCollection] sortedCollection];
    self.navigationItem.title = @"Rutas";
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"linen.png"]]];
    
    [self configureToolbar];
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
