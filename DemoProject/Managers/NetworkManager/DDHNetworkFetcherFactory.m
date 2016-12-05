//
//  NetworkFetcherFactory.m
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHNetworkFetcherFactory.h"
#import "DDHGooglePlaceNetworkFetcher.h"
#import "DDHNetworkFetcher.h"
@implementation DDHNetworkFetcherFactory
+(id<DDHNetworkFetcherProtocol>) createNetworkFetcher {
    //return [DDHGooglePlaceNetworkFetcher new];
    return [DDHNetworkFetcher new];
}
@end
