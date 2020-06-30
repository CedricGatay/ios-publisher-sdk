//
//  NSUserDefaults+Criteo.h
//  CriteoPublisherSdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Criteo)

- (BOOL)cr_containsKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
