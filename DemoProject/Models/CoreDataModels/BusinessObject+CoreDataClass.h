//
//  BusinessObject+CoreDataClass.h
//  
//
//  Created by MAX on 12/17/16.
//
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Menu, Order;

NS_ASSUME_NONNULL_BEGIN

@interface BusinessObject : NSManagedObject <BusinessProtocol>
@property (nullable, nonatomic, copy, ) NSString* iconURL;

@end

NS_ASSUME_NONNULL_END

#import "BusinessObject+CoreDataProperties.h"
