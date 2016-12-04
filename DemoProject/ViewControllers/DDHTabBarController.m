//
//  DDHTabBarController.m
//  DoorDashProject
//
//  Created by MAX on 11/30/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHTabBarController.h"
#import "DDHBusinessListViewController.h"
#import "DDHBusinessListFavoritesViewController.h"

@interface DDHTabBarController ()

@end

@implementation DDHTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //TODO: optimize extract to constants object based on enum of tabs;
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //create tabs
    DDHBusinessListViewController* listController = [storyboard instantiateViewControllerWithIdentifier:@"DDHBusinessListViewController"];
    listController.tabBarItem.image = [UIImage imageNamed:@"tab-explore"];
    listController.tabBarItem.title = @"Explore";
  
    //??? Have not figure out use one viewcontroller in storyboard and instantiate using different sub classes
    DDHBusinessListFavoritesViewController* listFavoritesController = [storyboard instantiateViewControllerWithIdentifier:@"DDHBusinessListFavoritesViewController"];
    listFavoritesController.tabBarItem.image = [UIImage imageNamed:@"tab-star"];
    listFavoritesController.tabBarItem.title = @"Favorites";
    
    UINavigationController* listNavigation = [[UINavigationController alloc] initWithRootViewController:listController];
    UINavigationController* listFavoritesNavigation = [[UINavigationController alloc] initWithRootViewController:listFavoritesController];
    
    self.viewControllers = @[listNavigation, listFavoritesNavigation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
