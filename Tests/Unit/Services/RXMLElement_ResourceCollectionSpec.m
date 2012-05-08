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


#import "RXMLElement+ResourceCollection.h"
#import "expanz_model_ResourceCollection.h"
#import "expanz_utils_BundleResource.h"
#import "RXMLElement.h"


SPEC_BEGIN(RXMLElement_ResourceCollection)

    describe(@"An activity with File Resources", ^{

        __block RXMLElement* resourceElement;

        beforeEach(^{
            NSString* xmlString = [BundleResource withName:@"ActivityWithFileResources.xml"];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString encoding:NSUTF8StringEncoding];
            resourceElement = [rootElement child:@"ExecXResult.ESA.Files"];
        });

        it(@"should add a FileResource for each file resource in the xml response.", ^{
            ResourceCollection* collection = [resourceElement asResourceCollectionWithTitle:@"Foobar"];
            LogDebug(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%@", collection);
            [[[collection fileResources] should] haveCountOf:1];
        });

    });

SPEC_END