//
//  DDHGooglePlaceParser.h
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHGooglePlaceParser : NSObject

+(NSArray<id<BusinessProtocol>>*) parse: (id) responseObject;

@end
