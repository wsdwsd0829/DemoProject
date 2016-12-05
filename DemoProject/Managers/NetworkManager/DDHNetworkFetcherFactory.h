//
//  NetworkFetcherFactory.h
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHNetworkFetcherProtocol.h"
@interface DDHNetworkFetcherFactory : NSObject
+(id<DDHNetworkFetcherProtocol>) createNetworkFetcher;
@end
