//
//  CRBidToken+Internal.h
//  CriteoPublisherSdk
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

#ifndef CRBidToken_Internal_h
#define CRBidToken_Internal_h

#import <Foundation/Foundation.h>
#import "CRBidToken.h"

@interface CRBidToken ()

@property(nonatomic, readonly) NSUUID* bidTokenUUID;

- (instancetype)initWithUUID:(NSUUID*)uuid NS_DESIGNATED_INITIALIZER;

@end

#endif /* CRBidToken_Internal_h */
