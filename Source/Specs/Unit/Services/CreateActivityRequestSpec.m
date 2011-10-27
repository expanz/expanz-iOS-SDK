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
#import "expanz_service_CreateActivityRequest.h"
#import "xml_Serializable.h"
#import "RXMLElement.h"


SPEC_BEGIN(CreateActivityRequestSpec)


describe(@"Object creation", ^{
    
    it(@"should allow initialization with activityName and sessionToken parameters.", ^{
        CreateActivityRequest* request = [[CreateActivityRequest alloc] initWithActivityName:@"Calculator" style:nil
                                                                                sessionToken:@"EggResponderxx238b"];
        assertThat([request activityName], equalTo(@"Calculator")); 
        assertThat([request sessionToken], equalTo(@"EggResponderxx238b"));
    });

});

describe(@"Web service integration.", ^{
    
    it(@"should be able to marshal itself to XML to send over the wire as a web service request.", ^{
        id<xml_Serializable> request = [[CreateActivityRequest alloc] initWithActivityName:@"Calculator"
                                                                                style:nil sessionToken:@"xx2348b"];
        RXMLElement* e = [RXMLElement elementFromXMLString:[request toXml]]; 
        assertThat(e, notNilValue()); 
        
    });
});


SPEC_END
