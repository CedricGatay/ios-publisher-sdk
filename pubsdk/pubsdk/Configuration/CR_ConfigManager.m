//
//  CR_ConfigManager.m
//  CriteoPublisherSdk
//
//  Copyright © 2018-2020 Criteo. All rights reserved.
//

#import "CR_ConfigManager.h"

@interface CR_ConfigManager ()

@property(nonatomic, strong) NSUserDefaults *userDefault;

@end

@implementation CR_ConfigManager {
    CR_ApiHandler *apiHandler;
}

- (instancetype)initWithApiHandler:(CR_ApiHandler *)apiHandler
                       userDefault:(NSUserDefaults *)userDefault {
    if (self = [super init]) {
        self->apiHandler = apiHandler;
        _userDefault = userDefault;
    }

    return self;
}

- (void)refreshConfig:(CR_Config *)config {
    [self->apiHandler getConfig:config
                ahConfigHandler:^(NSDictionary *configValues) {
                    if (configValues[@"killSwitch"] && [configValues[@"killSwitch"] isKindOfClass:NSNumber.class]) {
                        config.killSwitch = ((NSNumber *) configValues[@"killSwitch"]).boolValue;
                    }
                    if (configValues[@"csmEnabled"] && [configValues[@"csmEnabled"] isKindOfClass:NSNumber.class]) {
                        config.csmEnabled = ((NSNumber *) configValues[@"csmEnabled"]).boolValue;
                    }
                    if (configValues[@"iOSAdTagUrlMode"] && [configValues[@"iOSAdTagUrlMode"] isKindOfClass:NSString.class]) {
                        config.adTagUrlMode = (NSString *) configValues[@"iOSAdTagUrlMode"];
                    }
                    if (configValues[@"iOSDisplayUrlMacro"] && [configValues[@"iOSDisplayUrlMacro"] isKindOfClass:NSString.class]) {
                        config.displayURLMacro = (NSString *) configValues[@"iOSDisplayUrlMacro"];
                    }
                    if (configValues[@"iOSWidthMacro"] && [configValues[@"iOSWidthMacro"] isKindOfClass:NSString.class]) {
                        config.viewportWidthMacro = (NSString *) configValues[@"iOSWidthMacro"];
                    }
                }];
}

@end
