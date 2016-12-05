//
//  DDHBusinessCell.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DDHBusinessCell ()

//cell outlets
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliveryLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliverTimeLabel;

@end

@implementation DDHBusinessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)updateUI {
    self.nameLabel.text = self.viewModel.name;
    self.typeLabel.text = self.viewModel.type;
    self.deliveryLabel.text = self.viewModel.delivery;
    self.deliverTimeLabel.text = self.viewModel.deliverTime;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString: [self.viewModel iconURL]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.iconView.clipsToBounds = YES;
}


@end
