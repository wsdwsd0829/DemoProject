//
//  DDHBusinessCellViewModel.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHBusiness.h"


@interface DDHBusinessCellViewModel : NSObject

- (instancetype)initWithBusiness: (DDHBusiness*) business;

-(NSString*) name;
-(NSString*) type;
-(NSString*) delivery;
-(NSString*) deliverTime;
-(NSString*) iconURL;
@end
