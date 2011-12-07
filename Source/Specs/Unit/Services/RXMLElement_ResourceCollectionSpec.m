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
#import "RXMLElement+ResourceCollection.h"
#import "expanz_model_ResourceCollection.h"


SPEC_BEGIN(RXMLElement_ResourceCollection)

    describe(@"An activity with File Resources", ^{

        __block RXMLElement* resourceElement;

        beforeEach(^{
            NSString* xmlString = [TestResource withName:@"ActivityWithFileResources.xml"];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString];
            resourceElement = [rootElement child:@"ExecXResult.ESA.Files"];
        });

        it(@"should add a FileResource for each file resource in the xml response.", ^{
            ResourceCollection* collection = [resourceElement asResourceCollection];
            assertThatInt([[collection fileResources] count], equalToInt(1));
        });

    });

    SPEC_END