//
//  NSError+CRErrors.h
//  CriteoPublisherSdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CRErrorCode) {
    CRErrorCodeInternalError,
    CRErrorCodeNoFill,
    CRErrorCodeNetworkError,
    CRErrorCodeInvalidRequest,
    CRErrorCodeInvalidParameter,

    CRErrorCodeInvalidErrorCode //the last error code
};

@interface NSError (CRErrors)

+ (NSError *)CRErrors_errorWithCode:(CRErrorCode)code;
+ (NSError *)CRErrors_errorWithCode:(CRErrorCode)code
               description:(nullable NSString *)description;
+ (NSString *)descriptionForCRErrorCode:(CRErrorCode)code;

@end

NS_ASSUME_NONNULL_END
