//
//  DDHTypeCell.h
//  DemoProject
//
//  Created by MAX on 12/18/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* const DDHTypeCellIdentifier = @"DDHTypeCell";

@interface DDHTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
