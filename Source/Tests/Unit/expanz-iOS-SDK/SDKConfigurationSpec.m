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
#import "expanz_iOS_SDKConfiguration.h"

SPEC_BEGIN(SDKConfigurationSpec)

    __block SDKConfiguration* configuration;
    beforeEach(^{
        configuration = [[SDKConfiguration alloc] init];
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
                [SDKConfiguration setConfigurationFile:@"foobar.xml"];
                [NSException raise:NSInternalInconsistencyException format:@"Should have thrown exception"];
            }
            @catch (NSException* e) {
                assertThat([e reason], equalTo(@"Config file named 'foobar.xml' not found."));
            }
        });

    });

    describe(@"Setting the global configuration", ^{

        __block SDKConfiguration* existingConfigurationForIntegrationTests;

        beforeEach(^{
            existingConfigurationForIntegrationTests = [SDKConfiguration globalConfiguration];
        });


        it(@"should allow setting the global configuration a class method", ^{

            [SDKConfiguration clearGlobalConfiguration];
            [SDKConfiguration setConfigurationFile:@"configFile.xml"];

            assertThat([SDKConfiguration globalConfiguration], notNilValue());
            assertThat([SDKConfiguration globalConfiguration].baseUrl, notNilValue());
            assertThat([SDKConfiguration globalConfiguration].preferredSite, notNilValue());
            assertThat([SDKConfiguration globalConfiguration].userType, notNilValue());

            assertThat([[SDKConfiguration globalConfiguration] createSessionServiceUrl], notNilValue());
            assertThat([[SDKConfiguration globalConfiguration] execXServiceUrl], notNilValue());
            assertThat([[SDKConfiguration globalConfiguration] getBlobServiceUrl], notNilValue());

        });

        afterEach(^{
            [SDKConfiguration clearGlobalConfiguration];
            [SDKConfiguration setGlobalConfiguration:existingConfigurationForIntegrationTests];
        });

    });



    SPEC_END
