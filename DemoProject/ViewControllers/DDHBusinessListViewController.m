//
//  DDHBusinessListViewController.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>

#import "DDHBusinessListViewController.h"
#import "DDHBusinessListViewModel.h"
#import "DDHBusinessCell.h"
#import "DDHBusinessCellViewModel.h"
#import "DDHBusinessDetailViewController.h"
#import "DDHBusinessDetailViewModel.h"
#import "DDHMapViewController.h"
#import "DDHBusinessListFavoritesViewController.h"

#import "DDHConstants.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface DDHBusinessListViewController ()<DDHMapViewControllerDelegate> {
}
@end

@implementation DDHBusinessListViewController

//MARK: life cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[DDHApplicationWideConstants doorDashThemeColor]}];
    //setup SVProgressHUD
    [SVProgressHUD setDefaultStyle: SVProgressHUDStyleDark];
    
    //setup tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0f;
    
    //setup view model
    [self p_setupViewModel];
}

-(void)p_setupViewModel {
    viewModel = [DDHBusinessListViewModel new];
    [viewModel loadBusinesses:^(NSArray *buses) {
        businesses = buses;
        [self.tableView reloadData];
    }];
}

-(void)viewWillAppear:(BOOL)animated {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(businessFavoriteChanged:) name:kNotificationFavoriteChanged object:nil];
}

-(void)businessFavoriteChanged: (NSNotification *) notification{
    if([notification.name isEqualToString:kNotificationFavoriteChanged]){
        DDHBusiness * bus = notification.userInfo[@"business"];
        DDHBusiness * changedBus = [[businesses filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"identifier = %@", bus.identifier]] firstObject];
        changedBus.favorite = bus.favorite;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}
//MARK: tableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return businesses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: kBusinessCellIdentifier forIndexPath: indexPath];
    [self p_configCell:cell forIndexPath:indexPath];
    
    
    return cell;
}
-(void) p_configCell: (UITableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath {
    if ([cell isKindOfClass:[DDHBusinessCell class] ]) {
        
        DDHBusinessCell* businessCell = (DDHBusinessCell*)cell;
        businessCell.viewModel = [[DDHBusinessCellViewModel alloc] initWithBusiness: businesses[indexPath.row]];
        [businessCell updateUI];
    }
}


//MARK: tableView DataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO: extract global vars and helpers;
    DDHBusinessDetailViewController* detailViewController =
    [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DDHBusinessDetailViewController"];
    detailViewController.viewModel = [[DDHBusinessDetailViewModel alloc] initWithBusiness: businesses[indexPath.row]];
    //UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController: detailViewController];
    detailViewController.navigationItem.title = ((DDHBusiness*)(businesses[indexPath.row])).name;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
//MARK: action handling
-(IBAction)selectAddressClicked:(id)sender {
    DDHMapViewController* mapViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DDHMapViewController"];
    mapViewController.delegate = self;
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController: mapViewController];
    [self presentViewController:nvc animated:YES completion:nil];
}

//MARK: MapViewControllerDelegate
-(void) didSelectAddress:(DDHAddress*) address fromViewController: (UIViewController*) viewController {
    //TODO make query and feed data/handle errors;
    
    [SVProgressHUD showWithStatus:@"Simulate Filtering"];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    });
}

@end
