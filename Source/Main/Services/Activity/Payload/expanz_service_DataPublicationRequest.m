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


#import "expanz_service_DataPublicationRequest.h"


@implementation expanz_service_DataPublicationRequest

@synthesize dataPublicationId = _dataPublicationId;
@synthesize populateMethod = _populateMethod;
@synthesize autoPopulate = _autoPopulate;

/* ================================================== Constructors ================================================== */
- (id) init {
    self = [super init]; 
    if (self) {
        _populateMethod = @"ListMe"; 
    }
    return self; 
}

- (id) initWithId:(NSString*)dataPublicationId populateMethod:(NSString*)populateMethod 
     autoPopulate:(BOOL)autoPopulate {
    
    self = [self init];
    _dataPublicationId = [dataPublicationId retain];
    if (![populateMethod isEqualToString:@"ListMe"]) {
        [_populateMethod release];
        _populateMethod = [populateMethod retain];        
    }
    _autoPopulate = autoPopulate;
    return self;
}

/* ================================================= Protocol Methods =============================================== */

#define kXmlTemplate @"<DataPublication id=\"%@\" populateMethod=\"%@\" autoPopulate=\"%@\"/>"
- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTemplate, _dataPublicationId, _populateMethod,
            _autoPopulate == YES ? @"1" : @"0"];
}



/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_dataPublicationId release];
    [_populateMethod release];
    [super dealloc];
}


@end