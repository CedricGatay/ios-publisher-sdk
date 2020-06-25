//
//  CR_ThreadManagerWaiter.m
//  CriteoPublisherSdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CR_ThreadManager.h"
#import "CR_ThreadManagerWaiter.h"

@interface CR_ThreadManagerWaiter ()

@property(class, assign, nonatomic, readonly) NSTimeInterval defaultTimeout;
@property(class, assign, nonatomic, readonly) NSTimeInterval timeoutForPerformanceTests;

@property(nonatomic, strong, readonly) CR_ThreadManager *threadManager;
@property(nonatomic, strong) XCTestExpectation *expectation;

@end

@implementation CR_ThreadManagerWaiter

#pragma mark - Class methods

+ (NSTimeInterval)defaultTimeout {
  return 15.;
}

+ (NSTimeInterval)timeoutForPerformanceTests {
  return 30.;
}

#pragma mark - Life Cycle

- (instancetype)initWithThreadManager:(CR_ThreadManager *)threadManager {
  if (self = [super init]) {
    _threadManager = threadManager;
  }
  return self;
}

#pragma mark - Public

- (void)waitIdle {
  [self waitIdleWithTimeout:self.class.defaultTimeout];
}

- (void)waitIdleForPerformanceTests {
  [self waitIdleWithTimeout:self.class.timeoutForPerformanceTests];
}

- (void)waitIdleWithTimeout:(NSTimeInterval)timeout {
  NSString *keypath = NSStringFromSelector(@selector(isIdle));
  XCTKVOExpectation *expectation = [[XCTKVOExpectation alloc] initWithKeyPath:keypath
                                                                       object:self.threadManager
                                                                expectedValue:@YES];
  XCTWaiter *waiter = [[XCTWaiter alloc] init];
  XCTWaiterResult result = [waiter waitForExpectations:@[ expectation ] timeout:timeout];
  NSAssert(result == XCTWaiterResultCompleted,
           @"Idle mode did not finished (reason = %ld, nbBlockInProgress = %ld)", (long)result,
           (long)self.threadManager.blockInProgressCounter);
  result = result;  // to avoid compilation error
}

@end
