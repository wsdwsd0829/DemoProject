//
//  DDHBusinessCellViewModel.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessCellViewModel.h"

@interface DDHBusinessCellViewModel () {
    DDHBusiness* business;
}
@end

@implementation DDHBusinessCellViewModel
- (instancetype)initWithBusiness: (DDHBusiness*) bus
{
    self = [super init];
    if (self) {
        business = bus;
    }
    return self;
}

-(NSString*) name {
    return business.name;
}
-(NSString*) type {
    return business.type;
}
-(NSString*) delivery {
    //TODO localized string
    NSString* price = business.deliverPrice == 0 ? @"Free" : [NSString stringWithFormat:@"$%.2f", business.deliverPrice];
    return [NSString stringWithFormat: NSLocalizedString(@"%@ delivery", nil), price];
}
-(NSString*) deliverTime {
    //TODO handle hour
    return [NSString stringWithFormat: NSLocalizedString(@"%d min", nil), business.deliverTime];
}
-(NSString*) iconURL {
    return business.iconURL;
}
/*
 self.nameLabel.text = self.viewModel.name;
 self.typeLabel.text = self.viewModel.type;
 self.deliveryLabel.text = self.viewModel.delivery;
 self.deliverTimeLabel.text = self.viewModel.deliverTime;
 */


@end
