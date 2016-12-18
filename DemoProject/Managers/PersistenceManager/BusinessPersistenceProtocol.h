//
//  BusinessPeristenceManager.h
//  DemoProject
//
//  Created by MAX on 12/18/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusinessPersistenceManager <NSObject>
-(void) fetchFavoritedBusinesses: void(^)(id<BusinessProtocol>) handler;
-(void) save;
@end
