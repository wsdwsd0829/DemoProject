//
//  BusinessObject+CoreDataProperties.m
//  
//
//  Created by MAX on 12/17/16.
//
//  This file was automatically generated and should not be edited.
//

#import "BusinessObject+CoreDataProperties.h"

@implementation BusinessObject (CoreDataProperties)

+ (NSFetchRequest<BusinessObject *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Business"];
}

@dynamic businessId;
@dynamic createTime;
@dynamic deliverPrice;
@dynamic deliverTime;
@dynamic favorited;
@dynamic name;
@dynamic ordered;
@dynamic type;
@dynamic iconURL;
@dynamic googlePhotoReference;
@dynamic menus;
@dynamic orders;

@end
