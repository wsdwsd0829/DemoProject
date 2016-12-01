//
//  DDHBussinessListFavoritesViewModel.m
//  DoorDashProject
//
//  Created by MAX on 11/30/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessListFavoritesViewModel.h"

@implementation DDHBusinessListFavoritesViewModel

-(void) loadBusinesses: (void(^)(NSArray*)) handler {
    //TODO: fetch network handle in backend. 
    [fetcher fetchFavoriteBusinesses:^(NSArray * buses) {
        handler(buses);
    }];
}

@end
