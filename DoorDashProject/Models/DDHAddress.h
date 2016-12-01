//
//  Address.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDHBusiness;

@interface DDHAddress : NSObject

@property (nonatomic) float longitude;
@property (nonatomic) float latitude;

@property (nonatomic, weak) DDHBusiness* business;

@end
