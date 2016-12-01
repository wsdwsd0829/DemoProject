//
//  DDHMenu.m
//  DoorDashProject
//
//  Created by MAX on 11/29/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHMenuItem.h"

@implementation DDHMenuItem

- (instancetype)initWithName: (NSString*) name withIdentifier:(NSString*) identifier
{
    self = [super init];
    if (self) {
        _name = name;
        _identifier = identifier;
    }
    return self;
}

@end
