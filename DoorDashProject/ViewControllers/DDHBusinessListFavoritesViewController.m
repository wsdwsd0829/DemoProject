//
//  DDHBusinessListFavoritesViewController.m
//  DoorDashProject
//
//  Created by MAX on 11/30/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessListFavoritesViewController.h"
#import "DDHBusinessListFavoritesViewModel.h"

@interface DDHBusinessListFavoritesViewController ()  {
}

@end

@implementation DDHBusinessListFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [viewModel loadBusinesses:^(NSArray *buses) {
        businesses = buses;
        [self.tableView reloadData];
    }];
}

-(void)p_setupViewModel {
    viewModel = [DDHBusinessListFavoritesViewModel new];
}



@end
