//
//  DDHBusinessCell.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHBusinessCellViewModel.h"

static NSString* kBusinessCellIdentifier = @"DDHBusinessCell";

@interface DDHBusinessCell : UITableViewCell

@property (nonatomic) DDHBusinessCellViewModel* viewModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

-(void)updateUI;

@end
