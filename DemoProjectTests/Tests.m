//
//  Tests.m
//  DemoProject
//
//  Created by MAX on 12/4/16.
//  Copyright © 2016 MAX. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDHBusinessDetailViewModel.h"
#import "DDHBusiness.h"

@interface Tests : XCTestCase {
    DDHBusinessDetailViewModel * detailViewModel;
    DDHBusiness* business;
}


@end

@implementation Tests

- (void)setUp {
    [super setUp];
    business = [[DDHBusiness alloc] initWithName: @"MockBusiness" withIdentifier: @"1"];
    detailViewModel = [[DDHBusinessDetailViewModel alloc] initWithBusiness: business];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    business = nil;
    detailViewModel = nil;
    [super tearDown];
}


- (void)testDeliverPriceAndTime {
    [business setDeliverPrice:5.99];
    [business setDeliverTime:40];
    NSString* deliverPriceAndTime = [detailViewModel deliverPriceAndTime];
    XCTAssertTrue([deliverPriceAndTime isEqualToString:@"$5.99 delivery in 40 min"]);
    
    [business setDeliverPrice:0];
    NSString* deliverPriceAndTime2 = [detailViewModel deliverPriceAndTime];
    XCTAssertTrue([deliverPriceAndTime2 isEqualToString:@"Free delivery in 40 min"]);
}

-(void) testFavoriteTitle {
    detailViewModel.favorite = YES;
    NSString* title1 = [detailViewModel favoriteButtonTitle];
    XCTAssertTrue([title1 isEqualToString:@"Favorited"]);
    XCTAssertTrue(business.favorite == YES);
    
    detailViewModel.favorite = NO;
    NSString* title2 = [detailViewModel favoriteButtonTitle];
    XCTAssertTrue([title2 isEqualToString:@"Add to Favorites"]);
    XCTAssertTrue(business.favorite == NO);
}
@end
