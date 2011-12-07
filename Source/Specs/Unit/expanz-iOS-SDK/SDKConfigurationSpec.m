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

        it(@"should allow setting the global configuration via an instance method (interface builder integration)", ^{
            [(id) configuration setConfigurationFile:@"expanz"];

            SDKConfiguration* globalConfiguration = [SDKConfiguration globalConfiguration];
            assertThat(globalConfiguration, notNilValue());
            assertThat(globalConfiguration.baseUrl, notNilValue());
            assertThat(globalConfiguration.preferredSite, notNilValue());
            assertThat([globalConfiguration createSessionServiceUrl], notNilValue());
            assertThat([globalConfiguration execXServiceUrl], notNilValue());
        });

        it(@"should allow setting the global configuration via a class method (API style invocation)", ^{
            [SDKConfiguration setConfigurationFile:@"expanz"];
            assertThat([SDKConfiguration globalConfiguration], notNilValue());
        });

        it(@"should throw exception for invalid configuration file name", ^{
            @try {
                [SDKConfiguration setConfigurationFile:@"foobar"];
                [NSException raise:NSInternalInconsistencyException format:@"Should have thrown exception"];
            }
            @catch (NSException* e) {
                assertThat([e reason], equalTo(@"Configuration file named 'foobar.xml' not found."));
            }
        });

    });


    afterEach(^{
        [configuration release];
    });


    SPEC_END
