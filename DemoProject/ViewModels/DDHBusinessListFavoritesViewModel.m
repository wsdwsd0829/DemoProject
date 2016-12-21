//
//  DDHBussinessListFavoritesViewModel.m
//  DoorDashProject
//
//  Created by MAX on 11/30/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessListFavoritesViewModel.h"
#import "BusinessPersistenceManager.h"
@implementation DDHBusinessListFavoritesViewModel {
    BusinessPersistenceManager* busPersistManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        busPersistManager = [BusinessPersistenceManager new];
    }
    return self;
}

-(void) loadBusinesses: (void(^)(NSArray*)) handler {
    //TODO: fetch network handle in backend.
    /*
    [fetcher fetchFavoriteBusinesses:^(NSArray * buses) {
        handler(buses);
    }];
     */
    [busPersistManager fetchFavoritedBusinesses:^(NSArray<id<BusinessProtocol>> * buses) {
        handler(buses);
    }];
}

@end
