//
//  DDHBusinessListViewController.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHBusinessListViewModelProtocol.h"

@interface DDHBusinessListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    id<DDHBusinessListViewModelProtocol> viewModel;
    NSArray* businesses;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
