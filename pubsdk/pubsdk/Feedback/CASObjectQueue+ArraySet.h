//
//  CASObjectQueue+ArraySet.h
//  pubsdk
//
//  Created by Romain Lofaso on 4/3/20.
//  Copyright © 2020 Criteo. All rights reserved.
//

#import "CASObjectQueue.h"
#import "CR_FeedbackMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface CASObjectQueue (ArraySet)

/**
 *  Adds an element to the end of the queue or assert if the object already exists.
 */
- (void)addFeedbackMessage:(CR_FeedbackMessage *)data;
/**
 * Return YES if the queue contains the given element.
 */
- (BOOL)containsFeedbackMessage:(CR_FeedbackMessage *)data;
/**
 * Return all the queued elements as an array.
 */
- (NSArray *)allFeedbackMessages;

@end

NS_ASSUME_NONNULL_END
