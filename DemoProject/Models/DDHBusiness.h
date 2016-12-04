//
//  Business.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHAddress.h"
#import "DDHMenuItem.h"

@interface DDHBusiness : NSObject

-(instancetype) initWithName: (NSString*) name withIdentifier: (NSString*) identifier;

@property (nonatomic, copy, readonly) NSString* identifier;
@property (nonatomic, copy, readonly) NSString* name;
@property (nonatomic, copy, readonly) NSString* type;

@property (nonatomic, copy) NSString* iconURL;
@property (nonatomic, assign, readonly) float deliverPrice;
@property (nonatomic, assign, readonly) int deliverTime; //int in min
@property (nonatomic, getter=isFavorite) BOOL favorite;

@property (nonatomic, strong) DDHAddress* address;
@property (nonatomic, strong) NSArray<DDHMenuItem*>* menuItems;

-(void)setDeliverPrice: (float) price;
-(void)setDeliverTime: (int) time;

@end
