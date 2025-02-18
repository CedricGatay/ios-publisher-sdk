//
//  UIWebView+Testing.m
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

#import "UIWebView+Testing.h"

// Remove a warning about UIWebView deprecation.
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@implementation UIWebView (Testing)

- (NSString *)testing_getHtmlContent {
  NSString *script =
      @"(function() { return document.getElementsByTagName('html')[0].outerHTML; })();";
  return [self stringByEvaluatingJavaScriptFromString:script];
}

@end

#pragma GCC diagnostic pop
