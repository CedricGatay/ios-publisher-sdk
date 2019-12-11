//
//  CR_DataProtectionConsentTests.m
//  pubsdkTests
//
//  Created by Adwait Kulkarni on 1/23/19.
//  Copyright © 2019 Criteo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

#import "CR_DataProtectionConsent.h"
#import "CR_DataProtectionConsentMock.h"

NSString * const CR_DataProtectionConsentTestsApprovedVendorString = @"0000000000000010000000000000000000000100000000000000000000000000000000000000000000000000001";
NSString * const CR_DataProtectionConsentTestsUnapprovedVendorString = @"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
NSString * const CR_DataProtectionConsentTestsMalformed80CharsVendorString = @"000000000000000000000000000000000000000000000000000000000000000000000000000000000";
NSString * const CR_DataProtectionConsentTestsMalformed90CharsVendorString = @"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";


@interface CR_DataProtectionConsentTests : XCTestCase

@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, assign) BOOL defaultGdprApplies;
@property (nonatomic, strong) NSString *defaultConsentString;

@end

@implementation CR_DataProtectionConsentTests

- (void)setUp
{
    self.defaultGdprApplies = YES;
    self.defaultConsentString = CR_DataProtectionConsentMockDefaultConsentString;

    NSNumber *defaultGdprAppliesNumber = [NSNumber numberWithBool:self.defaultGdprApplies];

    self.userDefaults = [[NSUserDefaults alloc] init];
    [self.userDefaults setObject:defaultGdprAppliesNumber forKey:@"IABConsent_SubjectToGDPR"];
    [self.userDefaults setObject:self.defaultConsentString forKey:@"IABConsent_ConsentString"];
}

- (void)testGdprGet
{

    NSString *vendorString = CR_DataProtectionConsentTestsApprovedVendorString;
    [self.userDefaults setObject:vendorString forKey:@"IABConsent_ParsedVendorConsents"];

    CR_DataProtectionConsent *consent = [[CR_DataProtectionConsent alloc] initWithUserDefaults:self.userDefaults];

    XCTAssertEqual([consent consentGiven], YES);
    XCTAssertEqualObjects(self.defaultConsentString, consent.consentString);
    XCTAssertEqual([consent gdprApplies], self.defaultGdprApplies);
}

- (void)testGdprGetCriteoNotApprovedVendor
{
    NSString *vendorString = CR_DataProtectionConsentTestsUnapprovedVendorString;
    [self.userDefaults setObject:vendorString forKey:@"IABConsent_ParsedVendorConsents"];

    CR_DataProtectionConsent *consent = [[CR_DataProtectionConsent alloc] initWithUserDefaults:self.userDefaults];

    XCTAssertEqual([consent consentGiven], NO);
    XCTAssertEqualObjects(self.defaultConsentString, consent.consentString);
    XCTAssertEqual([consent gdprApplies], self.defaultGdprApplies);
}

- (void)testTheTestThatIsnt
{
    NSString *vendorString = CR_DataProtectionConsentTestsMalformed80CharsVendorString;
    [self.userDefaults setObject:vendorString forKey:@"IABConsent_ParsedVendorConsents"];

    CR_DataProtectionConsent *consent = [[CR_DataProtectionConsent alloc] initWithUserDefaults:self.userDefaults];

    XCTAssertEqual([consent consentGiven], NO);
    XCTAssertEqualObjects(self.defaultConsentString, consent.consentString);
    XCTAssertEqual([consent gdprApplies], self.defaultGdprApplies);
}

- (void) testTheTestThatIsnt_2
{
    NSString *vendorString = CR_DataProtectionConsentTestsMalformed90CharsVendorString;
    [self.userDefaults setObject:vendorString forKey:@"IABConsent_ParsedVendorConsents"];

    CR_DataProtectionConsent *consent = [[CR_DataProtectionConsent alloc] initWithUserDefaults:self.userDefaults];

    XCTAssertEqual([consent consentGiven], NO);
    XCTAssertEqualObjects(self.defaultConsentString, consent.consentString);
    XCTAssertEqual([consent gdprApplies], self.defaultGdprApplies);
}

- (void)testGetUsPrivacyIABContent
{
    [self.userDefaults setObject:CR_DataProtectionConsentMockDefaultUsPrivacyIabConsentString
                          forKey:CR_DataProtectionConsentUsPrivacyIabConsentStringKey];

    CR_DataProtectionConsent *consent = [[CR_DataProtectionConsent alloc] initWithUserDefaults:self.userDefaults];

    NSString *actualUspIab = consent.usPrivacyIabConsentString;
    XCTAssertEqualObjects(actualUspIab, CR_DataProtectionConsentMockDefaultUsPrivacyIabConsentString);
}

@end
