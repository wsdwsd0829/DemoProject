//
//  BusinessListViewModel.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHBusinessListViewModelProtocol.h"
#import "DDHNetworkFetcher.h"

@interface DDHBusinessListViewModel : NSObject<DDHBusinessListViewModelProtocol> {
    DDHNetworkFetcher* fetcher;
}
///get business from network
-(void) loadBusinesses: (void(^)(NSArray*)) handler;

@end
