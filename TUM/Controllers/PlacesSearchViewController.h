//
//  PlacesSearchViewController.h
//  TUM
//
//  Created by Alejandro on 27/08/12.
//  Copyright (c) 2012 UNAM IIMAS Disca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "Places.h"
#import "PlaceOnMapDelegate.h"
#import "UITableViewCellForPlaceRow.h"

@interface PlacesSearchViewController : UITableViewController <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *temporaryPlaces;
    NSArray *places;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    id<PlaceOnMapDelegate> delegate;
}

@property (nonatomic, strong) id<PlaceOnMapDelegate> delegate;
    
@end
