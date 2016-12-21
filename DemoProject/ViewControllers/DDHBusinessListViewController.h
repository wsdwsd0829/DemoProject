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
    NSArray* businesses;
    NSArray* filteredBusinesses;
    DDHAddress* searchAddress;
    UISearchController* searchController;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property  (nonatomic) id<DDHBusinessListViewModelProtocol> viewModel;

-(void) configCell: (UITableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath;
@end
