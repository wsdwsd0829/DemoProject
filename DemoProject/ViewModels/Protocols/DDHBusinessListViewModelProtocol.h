//
//  DDHBusinessListViewModelProtocol.h
//  DoorDashProject
//
//  Created by MAX on 11/30/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDHBusinessListViewModelProtocol <NSObject>

@property (nonatomic) DDHAddress* searchAddress;
@property (nonatomic, copy) NSString* searchTopic;

-(void) loadBusinesses: (void(^)(NSArray*)) handler;
-(void) loadBusinessesWithSearchText:(NSString*) text withLocationStr:(NSString*)locationStr withHandler: (void(^)(NSArray*)) handler;

@end
