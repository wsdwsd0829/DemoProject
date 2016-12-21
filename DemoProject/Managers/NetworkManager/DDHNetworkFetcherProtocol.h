//
//  DDHNetworkFetcherProtocol.h
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDHNetworkFetcherProtocol <NSObject>


-(void) fetchBusinesses: (void(^)(NSArray*)) handler;
-(void) fetchBusinessesWithSearchText:(NSString*)text withLocationString:(NSString*)locationStr withHandler:(void(^)(NSArray*)) handler;

-(void) fetchFavoriteBusinesses: (void(^)(NSArray*)) handler;

@end
