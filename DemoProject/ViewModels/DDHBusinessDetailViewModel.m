//
//  DDHBusinessDetailViewModel.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessDetailViewModel.h"
#import "DDHConstants.h"
#import "BusinessObject+CoreDataClass.h"
#import "DDHPersistenceManager.h"
@interface DDHBusinessDetailViewModel () {
    
}
@property (nonatomic) id<BusinessProtocol> business;

@end

@implementation DDHBusinessDetailViewModel

@dynamic favorite;
- (instancetype)initWithBusiness: (id<BusinessProtocol>) business
{
    self = [super init];
    if (self) {
        _business = business;
    }
    return self;
}

-(NSString*) deliverPriceAndTime {
    //TODO localized string
    NSString* price = self.business.deliverPrice == 0 ? @"Free" : [NSString stringWithFormat:@"$%.2f", self.business.deliverPrice];
    return [NSString stringWithFormat:@"%@ delivery in %d min", price, self.business.deliverTime];
}

-(NSArray<NSString*>*) menuItemNames {
    NSMutableArray* itemNames;
//    for(DDHMenuItem * item in self.business.menuItems){
//        [itemNames addObject: item.name];
//    }
//    return itemNames;
    itemNames = [NSMutableArray arrayWithArray: @[@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2",@"menu1", @"menu2"]];
    return itemNames;
}
-(BOOL)favorite {
    return self.business.favorited;
}

-(void)setFavorite: (BOOL) favorite {
    self.business.favorited = !self.business.favorited;
    //TODO abstract to persistent
    NSArray* busIdsArr = [[NSUserDefaults standardUserDefaults] arrayForKey:kUserDefaultsFavoriteBusiness];
    NSMutableSet<NSString*>* busIdsSet = [NSMutableSet setWithArray:busIdsArr];
    
    NSManagedObjectContext* parentContext = [[DDHPersistenceManager defaultManager] parentContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Business"];
    request.predicate = [NSPredicate predicateWithFormat:@"businessId = %@", self.business.businessId];
    NSArray* result = [[[DDHPersistenceManager defaultManager] parentContext] executeFetchRequest:request error:nil];
    NSLog(@"%@", result);

    if(favorite) {
        [busIdsSet addObject:self.business.businessId];
        [[NSUserDefaults standardUserDefaults] setObject: [busIdsSet allObjects] forKey:kUserDefaultsFavoriteBusiness];
        if (result.count == 0) {
            BusinessObject* bus = [NSEntityDescription insertNewObjectForEntityForName:@"Business" inManagedObjectContext: parentContext];
            bus.businessId = self.business.businessId;
            bus.name = self.business.name;
            bus.deliverTime = self.business.deliverTime;
            bus.favorited = self.business.favorited;
            bus.iconURL = self.business.iconURL;
        }else {
            ((BusinessObject*)result[0]).favorited = self.business.favorited;
        }
        [parentContext save:nil];
        //[[DDHPersistenceManager defaultManager] saveMainContext];
       
    }else {
        ((BusinessObject*)result[0]).favorited = self.business.favorited;
        [parentContext save:nil];
        //[[DDHPersistenceManager defaultManager] deleteObjects: result];
        [busIdsSet removeObject:self.business.businessId];
        [[NSUserDefaults standardUserDefaults] setObject: [busIdsSet allObjects] forKey:kUserDefaultsFavoriteBusiness];
    }
     //TODO ask network manager to update favorite by posting "favorite change business only post once success"
    NSDictionary* dict = @{ @"business": self.business };
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFavoriteChanged object: self userInfo:dict];
}

-(NSString*) favoriteButtonTitle {
    if(self.business.favorited) {
        return NSLocalizedString(@"Favorited", nil);
    } else {
        return NSLocalizedString(@"Add to Favorites", nil);
    }
}
-(NSString*) iconURL {
    return self.business.iconURL;
}
-(void) businessFavoriteChangedFor: (DDHBusiness*) bus {
    if(self.business.businessId == bus.businessId) {
        self.business.favorited = bus.favorited;
    }
}

@end
