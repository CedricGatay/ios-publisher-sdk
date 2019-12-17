//
//  CR_AssertDfp.h
//  pubsdk
//
//  Created by Romain Lofaso on 12/6/19.
//  Copyright © 2019 Criteo. All rights reserved.
//

#ifndef CR_AssertDfp_h
#define CR_AssertDfp_h

#define CR_AssertDfpCustomTargetingContainsCriteoBid(customTargeting) \
    XCTAssertEqualObjects(customTargeting[CR_TargetingKey_crtCpm], @"20.00"); \
    XCTAssertNotNil(customTargeting[CR_TargetingKey_crtDfpDisplayUrl]);

#endif /* CR_AssertDfp_h */
