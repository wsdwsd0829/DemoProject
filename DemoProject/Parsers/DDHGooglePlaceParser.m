//
//  DDHGooglePlaceParser.m
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHGooglePlaceParser.h"

@implementation DDHGooglePlaceParser

+(NSArray<DDHBusiness*>*) parse: (id) responseObject {
    NSMutableArray* busResults = [NSMutableArray new];
    NSDictionary* dict = (NSDictionary*)responseObject;
    NSDictionary* results = (NSDictionary*)dict[@"results"];
    if(results != nil) {
        for(NSDictionary<NSString*, id>* result in results){
            DDHBusiness* bus = [[DDHBusiness alloc] initWithName:result[@"name"] withIdentifier: result[@"id"]];
            NSArray* photos = (NSArray*)(result[@"photos"]);
            if(photos.count > 0) {
                [bus setGoogleReference: ((NSDictionary*)photos[0])[@"photo_reference"]];
            }
            [busResults addObject: bus];
        }
    }
    return busResults;
}

@end
