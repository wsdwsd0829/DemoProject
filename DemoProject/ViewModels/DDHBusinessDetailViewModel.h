//
//  DDHBusinessDetailViewModel.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHBusiness.h"

@interface DDHBusinessDetailViewModel : NSObject

@property (nonatomic) BOOL favorite;
- (instancetype)initWithBusiness: (DDHBusiness*) business;
-(NSString*) deliverPriceAndTime;
-(NSArray<NSString*>*) menuItemNames;
-(NSString*) favoriteButtonTitle;
-(NSString*) iconURL;
-(void) businessFavoriteChangedFor: (DDHBusiness*) bus;
@end
