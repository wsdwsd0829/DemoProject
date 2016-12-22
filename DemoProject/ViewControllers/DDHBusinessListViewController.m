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
#import "ShakeViewController.h"

NSString* const DDHBusinessDetailViewControllerIdentifier = @"DDHBusinessDetailViewController";
NSString* const DDHMapViewControllerIdentifier = @"DDHMapViewController";

@interface DDHBusinessListViewController ()<DDHMapViewControllerDelegate> {
    UIEdgeInsets defaultInsets;
}
@end

@implementation DDHBusinessListViewController

//MARK: life cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    //setup default value;
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
    [self p_setupNotifications];
    
    //for shaking
    [self becomeFirstResponder];
}

-(void)p_setupViewModel {
    self.viewModel = [DDHBusinessListViewModel new];
    
    [self.viewModel loadBusinesses:^(NSArray *buses) {
        businesses = buses;
        [self.tableView reloadData];
    }];
}

-(void)p_setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(businessFavoriteChanged:) name:kNotificationFavoriteChanged object:nil];
}

-(void)businessFavoriteChanged: (NSNotification *) notification{
    if([notification.name isEqualToString:kNotificationFavoriteChanged]){
        id<BusinessProtocol> bus = notification.userInfo[@"business"];
        id<BusinessProtocol> changedBus = [[businesses filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"businessId = %@", bus.businessId]] firstObject];
        changedBus.favorited = bus.favorited;
    }
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

//MARK: shake handling
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake) {
        ShakeViewController* svc = [Utils viewControllerWithIdentifier:@"ShakeViewController" fromStoryBoardNamed:@"Main"];
        //must set before present otherwise too late
        svc.view.backgroundColor = [UIColor clearColor];
        [self presentViewController:svc animated:YES completion:^{
        }];
    }
}

//MARK: Keyboard handling
-(void)keyboardWillShow: (NSNotification*) notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = self.tableView.contentInset;
    //!!!self.tableView.contentInset is 0 until view did layout subviews; and this can be called multiple times so need check if defautInsets is set or not
    if(defaultInsets.bottom == 0) {
        defaultInsets = self.tableView.contentInset;
    }
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets.bottom = keyboardSize.height;
    } else {
        contentInsets.bottom = keyboardSize.width;
    }
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.contentInset = defaultInsets;
    self.tableView.scrollIndicatorInsets = defaultInsets;
  
}
//MARK: tableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(searchController.active && ![searchController.searchBar.text isEqualToString: @""]) {
        return filteredBusinesses.count;
    }
    return businesses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: kBusinessCellIdentifier forIndexPath: indexPath];
    [self configCell:cell forIndexPath:indexPath];
    return cell;
}
    
-(void) configCell: (UITableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath {
    if ([cell isKindOfClass:[DDHBusinessCell class] ]) {
        DDHBusinessCell* businessCell = (DDHBusinessCell*)cell;
        DDHBusiness* bus;
//        if(searchController.active && ![searchController.searchBar.text isEqualToString: @""]) {
//            bus = filteredBusinesses[indexPath.row];
//        } else {
            bus = businesses[indexPath.row];
        //}
        businessCell.viewModel = [[DDHBusinessCellViewModel alloc] initWithBusiness: bus];
        [businessCell updateUI];
    }
}


//MARK: tableView DataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO: extract global vars and helpers;
    DDHBusinessDetailViewController* detailViewController = [Utils viewControllerWithIdentifier:DDHBusinessDetailViewControllerIdentifier fromStoryBoardNamed:@"Main"];
    detailViewController.viewModel = [[DDHBusinessDetailViewModel alloc] initWithBusiness: businesses[indexPath.row]];
    //UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController: detailViewController];
    detailViewController.navigationItem.title = ((DDHBusiness*)(businesses[indexPath.row])).name;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
    
//MARK: action handling
-(IBAction)selectAddressClicked:(id)sender {
    DDHMapViewController* mapViewController = [Utils viewControllerWithIdentifier: DDHMapViewControllerIdentifier fromStoryBoardNamed: @"Main"];
    mapViewController.delegate = self;
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController: mapViewController];
    [self presentViewController:nvc animated:YES completion:nil];
}

//MARK: MapViewControllerDelegate
-(void) didSelectAddress:(DDHAddress*) address fromViewController: (UIViewController*) viewController {
    searchAddress = address;
    //TODO make query and feed data/handle errors;
    [SVProgressHUD showWithStatus:@"Simulate Filtering"];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    });
}
@end
