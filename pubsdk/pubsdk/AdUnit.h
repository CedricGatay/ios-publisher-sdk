//
//  AdUnit.h
//  pubsdk
//
//  Created by Adwait Kulkarni on 1/7/19.
//  Copyright © 2019 Criteo. All rights reserved.
//

#ifndef AdUnit_h
#define AdUnit_h
#include <CoreGraphics/CoreGraphics.h>

@interface AdUnit : NSObject <NSCopying>

@property (readonly, nonatomic) NSString *adUnitId;
@property (readonly, nonatomic) CGSize size;
@property (readonly) NSUInteger hash;

- (BOOL) isEqual:(id) object;

- (instancetype) initWithAdUnitId:(NSString *) adUnitId
                            width:(CGFloat) width
                           height:(CGFloat) height;

- (instancetype) initWithAdUnitId:(NSString *) adUnitId
                             size:(CGSize) size
NS_DESIGNATED_INITIALIZER;

- (instancetype) init NS_UNAVAILABLE;

- (instancetype) copyWithZone:(NSZone *)zone;

- (NSString *) cdbSize;

@end

#endif /* AdUnit_h */
