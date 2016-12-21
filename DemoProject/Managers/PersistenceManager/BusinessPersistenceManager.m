//
//  BusinessPersistenceManager.m
//  DemoProject
//
//  Created by MAX on 12/18/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "BusinessPersistenceManager.h"

@implementation BusinessPersistenceManager
-(void) fetchFavoritedBusinesses: (void(^)(NSArray<id<BusinessProtocol>>*)) handler {
    NSFetchRequest* fr = [BusinessObject fetchRequest];
    fr.predicate = [NSPredicate predicateWithFormat:@"favorited = %@", @YES];
    NSArray<id<BusinessProtocol>>* results =  [[[DDHPersistenceManager defaultManager] parentContext] executeFetchRequest: fr error:nil];
    
    handler(results);
}

-(void) save {
    
}
@end
