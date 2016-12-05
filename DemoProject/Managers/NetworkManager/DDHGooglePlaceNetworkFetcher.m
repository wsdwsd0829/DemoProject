//
//  DDHGooglePlaceNetworkFetcher.m
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import "DDHGooglePlaceNetworkFetcher.h"
#import "DDHSecrets.h"
#import <AFNetworking/AFNetworking.h>
#import "DDHGooglePlaceParser.h"

static NSString* const kGooglePlaceSearchHostName = @"https://maps.googleapis.com/maps/api/place";

typedef NS_ENUM(int, ApiName) {
    NearbySearch,
    DetailSearch,
    Photo
};
typedef NS_ENUM(int, SearchFormat) {
    JSON,
    XML
};

//@interface DDHGooglePlaceNetworkFetcher (Helper)
//-(NSString*) p_searchFormat: (SearchFormat)format;
//-(NSString*)p_searchApi: (ApiName)apiName;
//@end

//MARK: Helpers to get url strings
@implementation DDHGooglePlaceNetworkFetcher (Helper)

+(NSString*)p_searchApi: (ApiName)apiName {
    switch(apiName) {
        case NearbySearch:
            return @"nearbysearch";
        case DetailSearch:
            return @"details";
        case Photo:
            return @"photo";
    }
}

+(NSString*) p_searchFormat: (SearchFormat)format {
    switch(format) {
        case JSON: return @"json";
        case XML: return @"xml";
    }
}

-(NSString*) p_searchNearByHostUrl {
    NSString* searchUrl = [NSString stringWithFormat:@"%@/%@/%@", kGooglePlaceSearchHostName, [DDHGooglePlaceNetworkFetcher p_searchApi: NearbySearch], [DDHGooglePlaceNetworkFetcher p_searchFormat:JSON]];
    
    return searchUrl;
}
@end

@interface DDHGooglePlaceNetworkFetcher() {
    //search parameters
    DDHAddress* addr;
    NSString* content;
    NSString* category;
    //parser
    DDHGooglePlaceParser* parser;
}
@end

@implementation DDHGooglePlaceNetworkFetcher

static NSString* searchFormat = @"json";

-(instancetype) initWithAddress:(DDHAddress*) address {
    self = [super init];
    if(self != nil) {
         addr = address;
        [self p_setup];
    }
    return self;
}

-(instancetype) initWithAddress:(DDHAddress*) address withContent: (NSString*)keyword withCategory:(NSString*)cate{
    self = [super init];
    if(self != nil) {
        addr = address;
        content = keyword;
        category = cate;
        [self p_setup];
    }
    return self;
}

-(void) p_setup{
    searchFormat = [DDHGooglePlaceNetworkFetcher p_searchFormat: JSON];
    parser = [DDHGooglePlaceParser new];
}

+(NSString*) photoUrlFromReference: (NSString* )ref {
    return [NSString stringWithFormat:@"%@/%@?maxwidth=%@&photoreference=%@&key=%@", kGooglePlaceSearchHostName, [DDHGooglePlaceNetworkFetcher p_searchApi:Photo], @400, ref, kGooglePlaceApiKey];
}

-(void) fetchBusinesses: (void(^)(NSArray*)) handler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSDictionary* parameters = @{@"key": kGooglePlaceApiKey, @"location": @"48.859294,2.347589", @"radius":@"50000", @"keywaord": @"cafe"};
    NSURL *URL = [NSURL URLWithString:[self p_searchNearbyUrlWithParameters: parameters]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //TODO create DataTask provide to abstract AFNetworking away;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            //parse array
            handler([DDHGooglePlaceParser parse:responseObject]);
        }
    }];
    [dataTask resume];
}

-(NSString*)p_searchNearbyUrlWithParameters: (NSDictionary<NSString*, NSString* >*) params {
    NSString* hostResult = [self p_searchNearByHostUrl];
    NSMutableArray* paramsResults = [NSMutableArray new];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableString* temp = [NSMutableString stringWithString:@""];
        [temp appendString:key];
        [temp appendString:@"="];
        //TODO escape obj
        [temp appendString: [Utils urlEncode:obj]];
        [paramsResults addObject:temp];
    }];
    
    return [NSString stringWithFormat:@"%@?%@", hostResult, [paramsResults componentsJoinedByString:@"&"]];
}

//TODO: add user and fetch remove for that user;
///async func; handler will be on main queue
-(void) fetchFavoriteBusinesses: (void(^)(NSArray*)) handler {
    
}

@end


