//
//  MenuViewController.m
//  TUM
//
//  Created by Alejandro on 13/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize controllers;

- (id) initWithControllers:(NSArray *)newControllers
{
    self = [super init];
    if (self) {
        [self setControllers:newControllers]; 
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
        
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noise.png"]]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.controllers.count; 
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    id<ControllerIconDelegate> controller = [controllers objectAtIndex:indexPath.row];
    UITableViewCellMenu *cell = [[UITableViewCellMenu alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell.menu"];
    [cell setTextLabel:[controller title] andIcon:[controller iconImageName]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        controller.centerController = [controllers objectAtIndex:indexPath.row];
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
