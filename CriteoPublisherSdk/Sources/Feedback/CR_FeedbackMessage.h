//
//  CR_FeedbackMessage.h
//  CriteoPublisherSdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CR_FeedbackMessage : NSObject <NSSecureCoding, NSCopying>

@property(strong, nonatomic) NSString *impressionId;
@property(strong, nonatomic) NSString *requestGroupId;
@property(strong, nonatomic) NSNumber *cdbCallStartTimestamp;
@property(strong, nonatomic) NSNumber *cdbCallEndTimestamp;
@property(strong, nonatomic) NSNumber *elapsedTimestamp;
@property(assign, nonatomic, getter=isTimeout) BOOL timeout;
@property(assign, nonatomic, getter=isExpired) BOOL expired;
@property(assign, nonatomic) BOOL cachedBidUsed;
@property(assign, nonatomic, getter=isReadyToSend, readonly) BOOL readyToSend;

@end

NS_ASSUME_NONNULL_END
