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


#import "SpecHelper.h"
#import "../../../Main/Assembly/expanz_ios_SdkConfiguration.h"

SPEC_BEGIN(SDKConfigurationSpec)

    __block SdkConfiguration* configuration;
    beforeEach(^{
        configuration = [[SdkConfiguration alloc] init];
    });

    describe(@"Object creation and destruction.", ^{

        it(@"should allow creation using the default constructor.", ^{
            assertThat(configuration, notNilValue());
        });

        it(@"should describe itself", ^{
            assertThat([configuration description], equalTo(@"SDKConfiguration: url=(null), preferredSite=(null)"));
        });

    });

    describe(@"loading configuration file", ^{

        it(@"should throw exception for invalid configuration file name", ^{
            @try {
                [SdkConfiguration setConfigurationFile:@"foobar.xml"];
                [NSException raise:NSInternalInconsistencyException format:@"Should have thrown exception"];
            }
            @catch (NSException* e) {
                assertThat([e reason], equalTo(@"Config file named 'foobar.xml' not found."));
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

            assertThat([SdkConfiguration globalConfiguration], notNilValue());
            assertThat([SdkConfiguration globalConfiguration].baseUrl, notNilValue());
            assertThat([SdkConfiguration globalConfiguration].preferredSite, notNilValue());
            assertThat([SdkConfiguration globalConfiguration].userType, notNilValue());

            assertThat([[SdkConfiguration globalConfiguration] createSessionServiceUrl], notNilValue());
            assertThat([[SdkConfiguration globalConfiguration] execXServiceUrl], notNilValue());
            assertThat([[SdkConfiguration globalConfiguration] getBlobServiceUrl], notNilValue());

        });

        afterEach(^{
            [SdkConfiguration clearGlobalConfiguration];
            [SdkConfiguration setGlobalConfiguration:existingConfigurationForIntegrationTests];
        });

    });



    SPEC_END
