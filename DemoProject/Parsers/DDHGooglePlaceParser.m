//
//  DDHGooglePlaceParser.m
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHGooglePlaceParser.h"
#import "DDHGooglePlaceNetworkFetcher.h"
@implementation DDHGooglePlaceParser

+(NSArray<id<BusinessProtocol>>*) parse: (id) responseObject {
    NSMutableArray* busResults = [NSMutableArray new];
    NSDictionary* dict = (NSDictionary*)responseObject;
    NSDictionary* results = (NSDictionary*)dict[@"results"];
    if(results != nil) {
        for(NSDictionary<NSString*, id>* result in results){
            id<BusinessProtocol>  bus = [BusinessObject MR_createEntity];
            //[NSEntityDescription insertNewObjectForEntityForName:@"Business" inManagedObjectContext: [[DDHPersistenceManager defaultManager] mainContext]];
            
            bus.name = result[@"name"];
            bus.businessId = result[@"id"];
            
            NSArray* photos = (NSArray*)(result[@"photos"]);
            if(photos.count > 0) {
               bus.googlePhotoReference = ((NSDictionary*)photos[0])[@"photo_reference"];
                bus.iconURL = [DDHGooglePlaceNetworkFetcher photoUrlFromReference: bus.googlePhotoReference];
            }
            [busResults addObject: bus];
        }
        //TODO: remove duplicate
        //[[DDHPersistenceManager defaultManager] saveMainContext];
    }
    return busResults;
}

@end
