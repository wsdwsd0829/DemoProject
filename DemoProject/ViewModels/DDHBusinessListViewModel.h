//
//  BusinessListViewModel.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHBusinessListViewModelProtocol.h"
#import "DDHNetworkFetcherProtocol.h"

@interface DDHBusinessListViewModel : NSObject<DDHBusinessListViewModelProtocol> {
    id<DDHNetworkFetcherProtocol> fetcher;
    //id<Bus> persistManager;
}
@property (nonatomic, copy) NSString* searchTopic;
@property (nonatomic) DDHAddress* searchAddress;
///get business from network
-(void) loadBusinessesWithSearchText:(NSString*) text withLocationStr:(NSString*)locationStr withHandler: (void(^)(NSArray*)) handler;

-(void) loadBusinesses: (void(^)(NSArray*)) handler;

@end
