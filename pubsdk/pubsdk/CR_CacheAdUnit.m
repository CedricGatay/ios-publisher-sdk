//
//  CR_CacheAdUnit.m
//  pubsdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import "CR_CacheAdUnit.h"

@implementation CR_CacheAdUnit
{
    NSUInteger _hash;
}

+ (instancetype)cacheAdUnitForInterstialWithAdUnitId:(NSString *)adUnitId
                                                size:(CGSize)size {
    return [[CR_CacheAdUnit alloc] initWithAdUnitId:adUnitId
                                               size:size
                                         adUnitType:CRAdUnitTypeInterstitial];
}

- (instancetype) init {
    CGSize size = CGSizeMake(0.0,0.0);
    return [self initWithAdUnitId:@"" size:size adUnitType:CRAdUnitTypeBanner];
}

- (instancetype)initWithAdUnitId:(NSString *)adUnitId
                            size:(CGSize)size
                      adUnitType:(CRAdUnitType)adUnitType {

    if(self = [super init]) {
        _adUnitId = adUnitId;
        _size = size;
        _adUnitType = adUnitType;
        // to get rid of the decimal point
        NSUInteger width = roundf(size.width);
        NSUInteger height = roundf(size.height);
        _hash = [[NSString stringWithFormat:@"%@_x_%lu_x_%lu_x_%@", _adUnitId, (unsigned long)width, (unsigned long)height, @(_adUnitType)] hash];
    }
    return self;
}

- (instancetype) initWithAdUnitId:(NSString *)adUnitId
                            width:(CGFloat)width
                           height:(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    return [self initWithAdUnitId:adUnitId size:size adUnitType:CRAdUnitTypeBanner];
}

- (NSUInteger) hash {
    return _hash;
}

- (BOOL)isEqual:(nullable id)object {
    if (![object isKindOfClass:[CR_CacheAdUnit class]]) {
        return NO;
    }
    CR_CacheAdUnit *obj = (CR_CacheAdUnit *) object;
    return self.hash == obj.hash;
}

- (BOOL) isValid {
    return self.adUnitId.length > 0 && roundf(self.size.width) > 0 && roundf(self.size.height) > 0;
}

- (instancetype) copyWithZone:(NSZone *)zone {
    CR_CacheAdUnit *copy = [[CR_CacheAdUnit alloc] initWithAdUnitId:self.adUnitId size:self.size adUnitType:self.adUnitType];
    return copy;
}

- (NSString *) cdbSize {
    return [NSString stringWithFormat:@"%lux%lu"
            , (unsigned long)self.size.width
            , (unsigned long)self.size.height];
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ adUnitId: %@", super.description, self.adUnitId];
}
@end
