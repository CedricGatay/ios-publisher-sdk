//
//  CR_MopubAsserts.h
//  CriteoPublisherSdkTests
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "CR_TargetingKeys.h"

#ifndef CR_AssertMopub_h
#define CR_AssertMopub_h

#define CR_AssertMopubKeywordContainsCriteoBid(keywords, initialKeywords, displayUrl)        \
  XCTAssertTrue([keywords containsString:initialKeywords]);                                  \
  XCTAssertTrue(                                                                             \
      [keywords containsString:[CR_TargetingKey_crtCpm stringByAppendingString:@":1.12"]]);  \
  XCTAssertTrue(                                                                             \
      [keywords containsString:[[CR_TargetingKey_crtDisplayUrl stringByAppendingString:@":"] \
                                   stringByAppendingString:displayUrl]]);

#endif /* CR_AssertMopub_h */
