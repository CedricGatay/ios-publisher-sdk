//
//  CR_HttpTests.m
//  pubsdkTests
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Criteo.h"
#import "Criteo+Internal.h"
#import "CR_Config.h"
#import "CR_BidManagerBuilder.h"
#import "CR_NetworkCaptor.h"
#import "Criteo+Testing.h"
#import "AdSupport/ASIdentifierManager.h"
#import "CR_ApiQueryKeys.h"
#import "CR_ThreadManager+Waiter.h"
#import "XCTestCase+Criteo.h"

@interface CR_HttpTests : XCTestCase

@property (strong, nonatomic) Criteo *criteo;

@end

@implementation CR_HttpTests

- (void)setUp {
    [super setUp];
    self.criteo = [Criteo testing_criteoWithNetworkCaptor];
}

- (void)tearDown {
    [self.criteo.bidManagerBuilder.threadManager waiter_waitIdle];
    [super tearDown];
}

- (void)testThreeMainApiCallsWerePerformed {
    XCTestExpectation *configApiCallExpectation = [self expectationWithDescription:@"configApiCallExpectation"];
    XCTestExpectation *eventApiCallExpectation = [self expectationWithDescription:@"eventApiCallExpectation"];
    XCTestExpectation *cdbApiCallExpectation = [self expectationWithDescription:@"cdbApiCallExpectation"];

    __weak typeof(self) weakSelf = self;
    [self.criteo.testing_networkCaptor setRequestListener:^(NSURL *url, CR_HTTPVerb verb, NSDictionary *body) {

        CR_Config *config = weakSelf.criteo.bidManagerBuilder.config;
        NSString *urlString = url.absoluteString;

        if ([urlString containsString:config.configUrl]) {
            [configApiCallExpectation fulfill];
        }

        if ([urlString containsString:config.appEventsUrl] && [urlString containsString:@"eventType=Launch"]) {
            [eventApiCallExpectation fulfill];
        }

        if ([urlString containsString:config.cdbUrl]) {
            [cdbApiCallExpectation fulfill];
        }
    }];

    [self.criteo testing_registerInterstitial];
    NSArray *expectations = @[
        configApiCallExpectation,
        eventApiCallExpectation,
        cdbApiCallExpectation,
    ];
    [self criteo_waitForExpectations:expectations];
}

- (void)testCdbApiCallDuringInitialisation {
    XCTestExpectation *expectation = [self expectationWithDescription:@"cdbApiCallExpectation"];
    CR_Config *config = self.criteo.bidManagerBuilder.config;
    CR_DeviceInfo *deviceInfo = self.criteo.bidManagerBuilder.deviceInfo;

    [self.criteo.testing_networkCaptor setRequestListener:^(NSURL *url, CR_HTTPVerb verb, NSDictionary *postBody) {
        NSDictionary *user = postBody[@"user"];
        if ([url.absoluteString containsString:config.cdbUrl] &&
            postBody[@"sdkVersion"] == config.sdkVersion &&
            user[@"deviceId"] == deviceInfo.deviceId &&
            user[@"deviceOs"] == config.deviceOs &&
            user[@"userAgent"] == deviceInfo.userAgent) {
            [expectation fulfill];
        }
    }];

    [self.criteo testing_registerInterstitial];

    [self criteo_waitForExpectations:@[expectation]];
}

- (void)testConfigApiCallDuringInitialisation {
    XCTestExpectation *expectation = [self expectationWithDescription:@"configApiCallExpectation"];
    CR_Config *config = self.criteo.bidManagerBuilder.config;
    NSString *appIdValue = [NSBundle mainBundle].bundleIdentifier;

    [self.criteo.testing_networkCaptor setRequestListener:^(NSURL *url, CR_HTTPVerb verb, NSDictionary *body) {
        if ([url.absoluteString containsString:config.configUrl] &&
            [self query:url.query hasParamKey:CR_ApiQueryKeys.appId withValue:appIdValue] &&
            [self query:url.query hasParamKey:CR_ApiQueryKeys.sdkVersion withValue:config.sdkVersion]) {
            [expectation fulfill];
        }
    }];

    [self.criteo testing_registerInterstitial];

    [self criteo_waitForExpectations:@[expectation]];
}

- (void)testEventApiCallDuringInitialization {
    XCTestExpectation *expectation = [self expectationWithDescription:@"eventApiCallExpectation"];

    ASIdentifierManager *idfaManager = [ASIdentifierManager sharedManager];
    NSString *limitedAdTrackingValue = idfaManager.advertisingTrackingEnabled ? @"0" : @"1";
    NSString *idfaValue = [idfaManager.advertisingIdentifier UUIDString];
    NSString *appIdValue = [NSBundle mainBundle].bundleIdentifier;

    __weak typeof(self) weakSelf = self;
    [self.criteo.testing_networkCaptor setRequestListener:^(NSURL *url, CR_HTTPVerb verb, NSDictionary *body) {
        if ([url.absoluteString containsString:weakSelf.criteo.bidManagerBuilder.config.appEventsUrl] &&
            [self query:url.query hasParamKey:CR_ApiQueryKeys.idfa withValue:idfaValue] &&
            [self query:url.query hasParamKey:CR_ApiQueryKeys.limitedAdTracking withValue:limitedAdTrackingValue] &&
            [self query:url.query hasParamKey:CR_ApiQueryKeys.appId withValue:appIdValue] &&
            [self query:url.query hasParamKey:CR_ApiQueryKeys.eventType withValue:@"Launch"]) {
            [expectation fulfill];
        }
    }];

    [self.criteo testing_registerInterstitial];

    [self criteo_waitForExpectations:@[expectation]];
}

- (void)testInitDoNotMakeNetworkCalls
{
    [self.criteo.bidManagerBuilder.threadManager waiter_waitIdle];

    XCTAssertEqualObjects(self.criteo.testing_networkCaptor.pendingRequests, @[]);
    XCTAssertEqualObjects(self.criteo.testing_networkCaptor.finishedRequests, @[]);
}


#pragma mark - Private methods

- (BOOL)query:(NSString *)query hasParamKey:(NSString *)key withValue:(NSString *)value {
    return [[query componentsSeparatedByString:@"&"] containsObject:[NSString stringWithFormat:@"%@=%@", key, value]];
}

@end
