//
//  DDHGooglePlaceNetworkFetcher.h
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHNetworkFetcherProtocol.h"
#import "DDHAddress.h"

@interface DDHGooglePlaceNetworkFetcher : NSObject <DDHNetworkFetcherProtocol>

+(NSString*) photoUrlFromReference: (NSString* )ref;

-(instancetype) initWithAddress:(DDHAddress*) address;
-(instancetype) initWithAddress:(DDHAddress*) address withContent: (NSString*)keyword withCategory:(NSString*)cate;

@end
