//
//  DeviceInfo.m
//  pubsdk
//
//  Created by Paul Davis on 1/28/19.
//  Copyright © 2019 Criteo. All rights reserved.
//

#import <WebKit/WebKit.h>

#import "DeviceInfo.h"

static WKWebView *webView = nil;
static NSString *userAgent = nil;

@implementation DeviceInfo

+ (void) initialize
{
    if ([self class] == [DeviceInfo class])
    {
        [self setupUserAgent];
    }
}

+ (void) setupUserAgent
{
    webView = [[WKWebView alloc] initWithFrame:CGRectZero];

    [webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable navigatorUserAgent, NSError * _Nullable error) {
        if (!error && [navigatorUserAgent isKindOfClass:NSString.class]) {
            userAgent = navigatorUserAgent;
        }

        webView = nil;
    }];
}

- (NSString*) userAgent
{
    return userAgent;
}

@end
