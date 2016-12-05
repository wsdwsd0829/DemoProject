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
}

-(void)viewWillAppear:(BOOL)animated {
    [viewModel loadBusinesses:^(NSArray *buses) {
        //things used in subclass need to declared in .h
        businesses = buses;
        [self.tableView reloadData];
    }];
}

-(void)p_setupViewModel {
    viewModel = [DDHBusinessListFavoritesViewModel new];
}



@end
