//
//  DDHMenu.h
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHMenuItem : NSObject

@property (nonatomic, readonly, copy) NSString* name;
@property (nonatomic, readonly, copy) NSString* identifier;

- (instancetype)initWithName: (NSString*) name withIdentifier:(NSString*) identifier;
//protential adding prices; not for this sample project...

@end
