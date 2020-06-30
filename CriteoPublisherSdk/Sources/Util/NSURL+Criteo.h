//
//  NSURL+Criteo.h
//  CriteoPublisherSdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#ifndef NSURL_Additions_h
#define NSURL_Additions_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Criteo)

+ (nullable NSURL *)cr_URLWithStringOrNil:(nullable NSString *)string;

@end

NS_ASSUME_NONNULL_END

#endif /* NSURL_Additions_h */
