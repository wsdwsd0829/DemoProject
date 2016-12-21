//
//  DDHBusinessListViewController+LocalSearch.m
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//


//TODO: Only use Search Bar
#import "DDHBusinessListViewController+LocalSearch.h"

#import "DDHBusinessSearchViewController.h"
#import "DDHBusinessListViewModel.h"

@implementation DDHBusinessListViewController (LocalSearch)

- (IBAction)searchBarButtonClicked:(id)sender {
    /*
     //Try using searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    searchBarView.autoresizingMask = 0;
    searchBar.delegate = self;
    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView; */
    DDHBusinessSearchViewController* svc = [Utils viewControllerWithIdentifier:@"DDHBusinessSearchViewController" fromStoryBoardNamed: @"Main"];
    svc.viewModel = [DDHBusinessListViewModel new];
    svc.viewModel.searchAddress = searchAddress;
    [self.navigationController pushViewController:svc animated:YES];
    
    
    /*
     
    searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = searchController.searchBar;
    [searchController.searchBar becomeFirstResponder];
     */
}

-(void)updateSearchResultsForSearchController:(UISearchController *)aSearchController {
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", aSearchController.searchBar.text];
    filteredBusinesses = [businesses filteredArrayUsingPredicate: pred];
    [self.tableView reloadData];
}


-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.tableView.tableHeaderView = nil;
}



@end
