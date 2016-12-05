//
//  BusinessListViewModel.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHBusinessListViewModel.h"
#import "DDHNetworkFetcher.h"
#import "DDHGooglePlaceNetworkFetcher.h"

@interface DDHBusinessListViewModel ()
//@property (nonatomic) DDHNetworkFetcher* fetcher;
@end

@implementation DDHBusinessListViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        fetcher = [self p_createFetcher];
    }
    return self;
}

-(id<DDHNetworkFetcherProtocol>)p_createFetcher {
    return [DDHGooglePlaceNetworkFetcher new];
}

//TODO: set addrss & params, that trigger fetch google

/// load businesses using DDHNetworkFetcher
-(void) loadBusinesses: (void(^)(NSArray*)) handler {
    [fetcher fetchBusinesses:^(NSArray * results) {
        handler(results);
    }];
}

@end
