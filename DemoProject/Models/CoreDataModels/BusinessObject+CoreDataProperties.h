//
//  BusinessObject+CoreDataProperties.h
//  
//
//  Created by MAX on 12/17/16.
//
//  This file was automatically generated and should not be edited.
//

#import "BusinessObject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BusinessObject (CoreDataProperties)

+ (NSFetchRequest<BusinessObject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *businessId;
@property (nullable, nonatomic, copy) NSDate *createTime;
@property (nonatomic) float deliverPrice;
@property (nonatomic) int16_t deliverTime;
@property (nonatomic) BOOL favorited;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL ordered;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *iconURL;
@property (nullable, nonatomic, copy) NSString *googlePhotoReference;
@property (nullable, nonatomic, retain) NSSet<Menu *> *menus;
@property (nullable, nonatomic, retain) NSSet<Order *> *orders;

@end

@interface BusinessObject (CoreDataGeneratedAccessors)

- (void)addMenusObject:(Menu *)value;
- (void)removeMenusObject:(Menu *)value;
- (void)addMenus:(NSSet<Menu *> *)values;
- (void)removeMenus:(NSSet<Menu *> *)values;

- (void)addOrdersObject:(Order *)value;
- (void)removeOrdersObject:(Order *)value;
- (void)addOrders:(NSSet<Order *> *)values;
- (void)removeOrders:(NSSet<Order *> *)values;

@end

NS_ASSUME_NONNULL_END
