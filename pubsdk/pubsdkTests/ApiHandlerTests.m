//
//  ApiHandlerTests.m
//  pubsdkTests
//
//  Created by Adwait Kulkarni on 1/14/19.
//  Copyright © 2019 Criteo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "../pubsdk/BidManager.h"
#import "../pubsdk/CacheManager.h"
#import "../pubsdk/NetworkManager.h"
#import "../pubsdk/GdprUserConsent.h"

@interface ApiHandlerTests : XCTestCase

@end

@implementation ApiHandlerTests

- (void) testApiHandlerCdbCall {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"All my expectations are fulfilled"];
    
    NetworkManager *mockNetworkManager = OCMStrictClassMock([NetworkManager class]);
    
    // Json response from CDB
    NSString *rawJsonCdbResponse = @"{\"slots\":[{\"placementId\": \"adunitid_1\",\"cpm\":1.1200000047683716,\"currency\":\"EUR\",\"width\": 300,\"height\": 250, \"ttl\": 600, \"creative\": \"<img src='https://demo.criteo.com/publishertag/preprodtest/creative.png' width='300' height='250' />\"}]}";
    
    NSData *responseData = [rawJsonCdbResponse dataUsingEncoding:NSUTF8StringEncoding];
    id error = [NSNull null];
    
    OCMStub([mockNetworkManager postToUrl:[OCMArg isKindOfClass:[NSURL class]]
                                 postBody:[OCMArg isKindOfClass:[NSDictionary class]]
                          responseHandler:([OCMArg invokeBlockWithArgs:responseData, error, nil])]);
    
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    apiHandler.networkManager = mockNetworkManager;
    
    CdbBid *testBid_1 = [[CdbBid alloc] initWithZoneId:nil placementId:@"adunitid_1" cpm:@(1.1200000047683716) currency:@"EUR" width:@(300) height:@(250) ttl:@(600) creative:@"<img src='https://demo.criteo.com/publishertag/preprodtest/creative.png' width='300' height='250' />" displayUrl:nil];
    
    AdUnit *testAdUnit_1 = [[AdUnit alloc] initWithAdUnitId:@"adunitid_1" width:300 height:250];
    
    GdprUserConsent *mockUserConsent = OCMStrictClassMock([GdprUserConsent class]);
    OCMStub([mockUserConsent gdprApplies]).andReturn(YES);
    OCMStub([mockUserConsent consentGiven]).andReturn(YES);
    OCMStub([mockUserConsent consentString]).andReturn(@"BOO9ZXlOO9auMAKABBITA1-AAAAZ17_______9______9uz_Gv_r_f__33e8_39v_h_7_u__7m_-zzV4-_lrQV1yPA1OrZArgEA");
    
    [apiHandler callCdb:testAdUnit_1 gdprConsent:mockUserConsent ahCdbResponseHandler:^(NSArray *cdbBids) {
        NSLog(@"Data length is %ld", [cdbBids count]);
        XCTAssertNotNil(cdbBids);
        XCTAssertNotEqual(0, [cdbBids count]);
        XCTAssertTrue([testBid_1 isEqual:cdbBids[0]]);
        [expectation fulfill];
    }];
    
    /*
     [mockNetworkManager postToUrl:[NSURL URLWithString:@"http://example.com"]
     queryParams:[NSDictionary dictionary]
     postBody:[NSDictionary dictionary]
     responseHandler:^(NSData *data, NSError *error) {
     NSLog(@"Block ran!");
     NSArray *cdbBids = [CdbBid getCdbResponsesFromData:data];
     NSLog(@"Data length is %ld", [cdbBids count]);
     [expectation fulfill];
     }];
     
     NSLog(@"%d", [mockNetworkManager isEqual:[NSNull null]]);
     */
    
    [self waitForExpectations:@[expectation] timeout:100];
}

@end
