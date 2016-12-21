//
//  DDHBusinessSearchViewController.m
//  DemoProject
//
//  Created by MAX on 12/18/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessSearchViewController.h"
#import "DDHTypeCell.h"
#import "DDHBusinessListViewModel.h"
@interface DDHBusinessSearchViewController () <UISearchResultsUpdating, UISearchBarDelegate>
{
    UISearchController* searchController;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(BOOL) p_shouldShowTrending;
@end

@implementation DDHBusinessSearchViewController

@synthesize tableView = _tableView;

-(void)viewDidLoad{
    [super viewDidLoad];
    searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = searchController.searchBar;
    [searchController.searchBar becomeFirstResponder];
}

-(void)p_setupViewModel {
    self.viewModel = [DDHBusinessListViewModel new];
}

-(BOOL)p_shouldShowTrending {
    return businesses.count == 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self p_shouldShowTrending]) {
        return [DDHHardCodeConstants trendingTopics].count;
    } else {
        return businesses.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if([self p_shouldShowTrending]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DDHTypeCell"];
        [self configCell:cell forIndexPath:indexPath];
    } else {
        //tableview business
        cell = [super tableView: tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}
-(void) configCell: (UITableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath {
    if([cell isKindOfClass: [DDHTypeCell class]]) {
        DDHTypeCell* typeCell = (DDHTypeCell*) cell;
        typeCell.typeLabel.text = [DDHHardCodeConstants trendingTopics][indexPath.row];
    } else {
        [super configCell:cell forIndexPath:indexPath];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self p_shouldShowTrending]) {
        [searchController.searchBar becomeFirstResponder];
        searchController.searchBar.text = [DDHHardCodeConstants trendingTopics][indexPath.row];
    }
}

//MARK: Searching
-(void)updateSearchResultsForSearchController:(UISearchController *)aSearchController {
    if([aSearchController.searchBar.text isEqualToString:@""]) {
        businesses = nil;
        [self.tableView reloadData];
    } else {
        
        [self.viewModel loadBusinesses:^(NSArray * results) {
            businesses = results;
            
            [self.tableView reloadData];
        }];
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //self.tableView.tableHeaderView = nil;
    businesses = nil;
    [self.tableView reloadData];
}
@end
