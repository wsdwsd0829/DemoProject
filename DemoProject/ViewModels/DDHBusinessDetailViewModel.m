//
//  DDHBusinessDetailViewModel.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessDetailViewModel.h"
#import "DDHConstants.h"

@interface DDHBusinessDetailViewModel ()
@property (nonatomic) DDHBusiness* business;

@end

@implementation DDHBusinessDetailViewModel

@dynamic favorite;
- (instancetype)initWithBusiness: (DDHBusiness*) business
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
    NSMutableArray* itemNames = [NSMutableArray new];
    for(DDHMenuItem * item in self.business.menuItems){
        [itemNames addObject: item.name];
    }
    return itemNames;
}
-(BOOL)favorite {
    return self.business.isFavorite;
}

-(void)setFavorite: (BOOL) favorite {
    self.business.favorite = !self.business.favorite;
    //TODO abstract to persistent
    NSArray* busIdsArr = [[NSUserDefaults standardUserDefaults] arrayForKey:kUserDefaultsFavoriteBusiness];
    NSMutableSet<NSString*>* busIdsSet = [NSMutableSet setWithArray:busIdsArr];

    if(favorite) {
        [busIdsSet addObject:self.business.identifier];
        [[NSUserDefaults standardUserDefaults] setObject: [busIdsSet allObjects] forKey:kUserDefaultsFavoriteBusiness];
    }else {
        [busIdsSet removeObject:self.business.identifier];
        [[NSUserDefaults standardUserDefaults] setObject: [busIdsSet allObjects] forKey:kUserDefaultsFavoriteBusiness];
    }
     //TODO ask network manager to update favorite by posting "favorite change business only post once success"
    NSDictionary* dict = @{ @"business": self.business };
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFavoriteChanged object: self userInfo:dict];
}

-(NSString*) favoriteButtonTitle {
    if(self.business.isFavorite) {
        return NSLocalizedString(@"Favorited", nil);
    } else {
        return NSLocalizedString(@"Add to Favorites", nil);
    }
}
-(NSString*) iconURL {
    return self.business.iconURL;
}
-(void) businessFavoriteChangedFor: (DDHBusiness*) bus {
    if(self.business.identifier == bus.identifier) {
        self.business.favorite = bus.favorite;
    }
}

@end
