//
//  Logging.h
//  pubsdk
//
//  Created by Paul Davis on 2/2/19.
//  Copyright © 2019 Criteo. All rights reserved.
//

#ifndef Logging_h
#define Logging_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#if (defined(DEBUG) || defined(CLOG_ENABLE_FOR_TESTING))
#define CLOG_ENABLE 1
#endif

#ifndef CLOG_ENABLE
#define CLOG_ENABLE 0
#endif


#if (CLOG_ENABLE)

#define CLog(args...) CLog_DoLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args)
void CLog_DoLog(const char *filename, int lineNum, const char *funcname, NSString *fmt, ...);

#else
#define CLog(args...) ((void)0)
#endif

NS_ASSUME_NONNULL_END

#endif /* Logging_h */
