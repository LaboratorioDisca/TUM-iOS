//
//  PlacesSearchViewController.m
//  TUM
//
//  Created by Alejandro on 27/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import "PlacesSearchViewController.h"

@interface PlacesSearchViewController ()

- (void) dismiss;
@end

@implementation PlacesSearchViewController

@synthesize delegate;

- (id) init
{
    self = [super init];
    if (self) {
        places = [[[Places currentCollection] collection] allValues];
        temporaryPlaces = [NSMutableArray arrayWithArray:places];
        
        self.title =NSLocalizedString(@"searches", @"");
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"dismiss_search", @"")
                                                                         style:UIBarButtonSystemItemCancel
                                                                        target:self
                                                                        action:@selector(dismiss)];
        [cancelButton setTintColor:[UIColor colorWithHexString:@"0x3565B5"]];
        
        [self.navigationItem setLeftBarButtonItem:cancelButton];
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
        searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        
        searchDisplayController.delegate = self;
        searchDisplayController.searchResultsDataSource = self;
        searchDisplayController.searchResultsDelegate = self;

        self.tableView.tableHeaderView = searchBar;   
        
        //[dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    if (tableView == self.tableView) {
        return [places count];
    } else if (tableView == self.searchDisplayController.searchResultsTableView){
        return [temporaryPlaces count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Place *place;

    if (tableView == self.tableView) {
        place = [places objectAtIndex:indexPath.row];
    } else if(tableView == self.searchDisplayController.searchResultsTableView){
        place = [temporaryPlaces objectAtIndex:indexPath.row];
    }
    UITableViewCellForPlaceRow *cell = [[UITableViewCellForPlaceRow alloc] initWithStyle:UITableViewCellStyleDefault 
                                                                         reuseIdentifier:@"place.item" 
                                                                                forPlace:place];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Place *place = (Place*) [temporaryPlaces objectAtIndex:indexPath.row];
    [delegate setPlaceOnMap:place];
    [self dismiss];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [temporaryPlaces removeAllObjects];
    
    for (Place *place in places) {
        NSRange textRange = [place.name.lowercaseString rangeOfString:searchString.lowercaseString];
        
        if(textRange.location != NSNotFound)
        {
            [temporaryPlaces addObject:place];
        }
    }
    
    return YES;
}

- (void) searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noise.png"]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"0x0E223D"]];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noise.png"]]];
    [self.tableView setFrame:CGRectMake(0, 0, [ApplicationConfig viewBounds].size.width, [ApplicationConfig viewBounds].size.height)];
}

- (void) dismiss
{
    [self dismissModalViewControllerAnimated:YES];
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
