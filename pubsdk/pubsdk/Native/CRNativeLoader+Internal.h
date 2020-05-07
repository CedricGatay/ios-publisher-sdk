//
//  CRNativeLoader+Internal.h
//  pubsdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import "CRNativeLoader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRNativeLoader ()

@property (nonatomic, strong, readonly) Criteo *criteo;
@property (nonatomic, strong, readonly) CRNativeAdUnit *adUnit;

- (instancetype)initWithAdUnit:(CRNativeAdUnit *)adUnit criteo:(Criteo *)criteo;

@end

NS_ASSUME_NONNULL_END
