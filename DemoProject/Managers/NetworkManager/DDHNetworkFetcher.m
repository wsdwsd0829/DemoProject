//
//  DDHNetworkFetcher.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHNetworkFetcher.h"
#import "DDHBusiness.h"
#import "DDHConstants.h"

@implementation DDHNetworkFetcher

-(void) fetchBusinesses: (void(^)(NSArray*)) handler {
    //TODO: call network data;
    //TODO: parser to get businesses;
    [self p_createMockBusinesses:^(NSArray *businesses) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(businesses);
        });
    }];
}

//TODO: add user and fetch remove for that user;
///async func; handler will be on main queue
-(void) fetchFavoriteBusinesses: (void(^)(NSArray*)) handler {
    [self p_createMockBusinesses:^(NSArray *businesses) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite = YES"];
        NSArray* results = [businesses filteredArrayUsingPredicate: predicate];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(results);
        });
    }];
}

-(void) p_createMockBusinesses: (void(^)(NSArray*)) handler  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray* businesses = [NSMutableArray new];
        for(int i = 0; i < 20; i++) {
            DDHBusiness* bus = [[DDHBusiness alloc] initWithName: [NSString stringWithFormat:@"Business %d", i] withIdentifier: [NSString stringWithFormat:@"%d", i]];
            NSMutableArray* menuItems = [NSMutableArray new];
            for(int j = 0; j < 20; j++) {
                DDHMenuItem* item = [[DDHMenuItem alloc] initWithName: [NSString stringWithFormat:@"Menu item %d", j] withIdentifier: [NSString stringWithFormat:@"%d", j]];
                [menuItems addObject: item];
            }
            bus.menuItems = menuItems;
            
            //mock price
            if(i%2 == 0) {
                [bus setDeliverPrice: 0];
            }
            //TODO use persistence method
            NSSet* busSet = [NSSet setWithArray: [[NSUserDefaults standardUserDefaults] arrayForKey:kUserDefaultsFavoriteBusiness]];
            if([busSet containsObject:bus.businessId]) {
                bus.favorited = YES;
            }
            
            [businesses addObject: bus];
        }
        handler(businesses);
    });
}

@end
