//
//  NetworkManager.h
//  pubsdk
//
//  Copyright © 2018 Criteo. All rights reserved.
//
//  Handles all network calls for pub-sdk code

#ifndef NetworkManager_h
#define NetworkManager_h

#import <Foundation/Foundation.h>

#import "CR_DeviceInfo.h"
#import "NetworkManagerDelegate.h"

typedef void (^NMResponse)(NSData *data, NSError *error);

@interface NetworkManager : NSObject

@property (nonatomic) id<NetworkManagerDelegate> delegate;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithDeviceInfo:(CR_DeviceInfo*)deviceInfo NS_DESIGNATED_INITIALIZER;

- (void) getFromUrl:(NSURL *) url
    responseHandler:(NMResponse) responseHandler;

// Assumes all POST calls are made via JSON
- (void) postToUrl:(NSURL *) url
          postBody:(NSDictionary *) postBody
   responseHandler:(NMResponse) responseHandler;

@end

#endif /* NetworkManager_h */
