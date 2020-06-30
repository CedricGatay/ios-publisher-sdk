//
//  CR_TokenCache.m
//  CriteoPublisherSdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import "CR_TokenCache.h"
#import "CRBidToken+Internal.h"

@interface CR_TokenCache ()

@property(strong, nonatomic) NSMutableDictionary<CRBidToken *, CR_TokenValue *> *tokenMap;

@end

@implementation CR_TokenCache

- (instancetype)init {
  if (self = [super init]) {
    _tokenMap = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (void)setTokenMapWithValue:(CR_TokenValue *)tokenValue forKey:(CRBidToken *)token {
  self.tokenMap[token] = tokenValue;
}

- (CR_TokenValue *)tokenValueForKey:(CRBidToken *)token {
  return self.tokenMap[token];
}

- (CRBidToken *)getTokenForBid:(CR_CdbBid *)cdbBid adUnitType:(CRAdUnitType)adUnitType {
  if (!cdbBid) {
    return nil;
  }
  CRBidToken *token = [CR_TokenCache generateToken];
  CRAdUnit *adUnit = [[CRAdUnit alloc] initWithAdUnitId:cdbBid.placementId adUnitType:adUnitType];
  CR_TokenValue *tokenValue = [[CR_TokenValue alloc] initWithCdbBid:cdbBid adUnit:adUnit];

  self.tokenMap[token] = tokenValue;
  return token;
}

- (CR_TokenValue *)getValueForToken:(CRBidToken *)token adUnitType:(CRAdUnitType)adUnitType {
  CR_TokenValue *value = [self tokenValueForKey:token];
  if (value) {
    if (value.adUnit.adUnitType != adUnitType) {
      return nil;
    }
    if ([value isExpired]) {
      [self.tokenMap removeObjectForKey:token];
      return nil;
    }
  }
  if (token) {
    [self.tokenMap removeObjectForKey:token];
  }
  return value;
}

+ (CRBidToken *)generateToken {
  NSUUID *uuid = [NSUUID UUID];
  return [[CRBidToken alloc] initWithUUID:uuid];
}

@end
