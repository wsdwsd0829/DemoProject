//
//  Business.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusiness.h"

@implementation DDHBusiness

-(instancetype) initWithName: (NSString*) name withIdentifier:(NSString *)identifier{
    self = [super init];
    if(self) {
        _identifier = identifier;
        _name = name;
        _deliverPrice = 4.99;
        _deliverTime = 45;
        _iconURL = @"http://dispatchcity.com/wp-content/uploads/2014/12/doordash-480x237.jpg";
        _type = @"Pizza";
        _favorite = NO;
    }
    return self;
}

-(BOOL) isFavorite {
    return _favorite;
}

-(void)setDeliverPrice: (float) price{
    _deliverPrice = price;
}
-(void)setDeliverTime: (int) time {
    _deliverTime = time;
}
@end
