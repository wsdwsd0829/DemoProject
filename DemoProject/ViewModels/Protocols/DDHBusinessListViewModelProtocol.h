//
//  DDHBusinessListViewModelProtocol.h
//  DoorDashProject
//
//  Created by MAX on 11/30/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDHBusinessListViewModelProtocol <NSObject>
-(void) loadBusinesses: (void(^)(NSArray*)) handler;
@end
