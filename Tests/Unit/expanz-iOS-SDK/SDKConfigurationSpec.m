////////////////////////////////////////////////////////////////////////////////
//
//  EXPANZ
//  Copyright 2008-2011 EXPANZ
//  All Rights Reserved.
//
//  NOTICE: Expanz permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import "../../../Source/Main/Core/expanz_utils_SdkConfiguration.h"

SPEC_BEGIN(SdkConfigurationSpec)

    __block SdkConfiguration* configuration;
    beforeEach(^{
        configuration = [[SdkConfiguration alloc] init];
    });

    describe(@"Object creation and destruction.", ^{

        it(@"should allow creation using the default constructor.", ^{
            [theValue(configuration) shouldNotBeNil];
        });

        it(@"should describe itself", ^{
            [[[configuration description] should] equal:@"SDKConfiguration: url=(null), preferredSite=(null)"];
        });

    });

    describe(@"loading configuration file", ^{

        it(@"should throw exception for invalid configuration file name", ^{
            @try {
                [SdkConfiguration setConfigurationFile:@"foobar.xml"];
                [NSException raise:NSInternalInconsistencyException format:@"Should have thrown exception"];
            }
            @catch (NSException* e) {
                [[[e reason] should] equal:@"Config file named 'foobar.xml' not found."];
            }
        });

    });

    describe(@"Setting the global configuration", ^{

        __block SdkConfiguration* existingConfigurationForIntegrationTests;

        beforeEach(^{
            existingConfigurationForIntegrationTests = [SdkConfiguration globalConfiguration];
        });


        it(@"should allow setting the global configuration a class method", ^{

            [SdkConfiguration clearGlobalConfiguration];
            [SdkConfiguration setConfigurationFile:@"configFile.xml"];


            [[SdkConfiguration globalConfiguration] shouldNotBeNil];
            [theValue([SdkConfiguration globalConfiguration].baseUrl) shouldNotBeNil];
            [theValue([SdkConfiguration globalConfiguration].preferredSite) shouldNotBeNil];
            [theValue([SdkConfiguration globalConfiguration].userType) shouldNotBeNil];

            [theValue([[SdkConfiguration globalConfiguration] createSessionServiceUrl]) shouldNotBeNil];
            [theValue([[SdkConfiguration globalConfiguration] execXServiceUrl]) shouldNotBeNil];
            [theValue([[SdkConfiguration globalConfiguration] getBlobServiceUrl]) shouldNotBeNil];

        });

        afterEach(^{
            [SdkConfiguration clearGlobalConfiguration];
            [SdkConfiguration setGlobalConfiguration:existingConfigurationForIntegrationTests];
        });

    });



    SPEC_END
