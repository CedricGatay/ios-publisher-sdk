//
//  NSArray+Criteo.m
//  pubsdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import "NSArray+Criteo.h"

@implementation NSArray (Criteo)

- (NSArray *)splitIntoChunks:(NSUInteger)chunkSize {
    NSMutableArray *chunks = [NSMutableArray new];
    for (int i = 0; i < self.count; i += chunkSize) {
        [chunks addObject:[self subarrayWithRange:NSMakeRange(i, MIN(chunkSize, self.count - i))]];
    }
    return chunks;
}

@end
