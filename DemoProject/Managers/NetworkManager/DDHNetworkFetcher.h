//
//  DDHNetworkFetcher.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHNetworkFetcherProtocol.h"

@interface DDHNetworkFetcher : NSObject <DDHNetworkFetcherProtocol>
-(void) fetchBusinesses: (void(^)(NSArray*)) handler;
-(void) fetchFavoriteBusinesses: (void(^)(NSArray*)) handler;
@end
