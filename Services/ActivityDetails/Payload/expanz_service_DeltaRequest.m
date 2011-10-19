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

#import "expanz_service_DeltaRequest.h"

@implementation expanz_service_DeltaRequest

@synthesize sessionToken = _sessionToken;
@synthesize activityHandle = _activityHandle;
@synthesize fieldId = _fieldId;
@synthesize fieldValue = _fieldValue;

/* ================================================== Constructors ================================================== */

- (id) initWithFieldId:(NSString*)fieldId fieldValue:(NSString*)fieldValue activityHandle:(NSString*)activityHandle
          sessionToken:(NSString*)sessionToken {
    
    self = [super init]; 
    if (self) {
        _fieldId = [fieldId retain]; 
        _fieldValue = [fieldValue retain]; 
        _activityHandle = [activityHandle retain]; 
        _sessionToken = [sessionToken retain]; 
    }
    return self; 
}

/* ================================================= Protocol Methods =============================================== */

#define kXmlTemplate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity activityHandle=\"%@\">\
<Delta id=\"%@\" value=\"%@\"/></Activity></ESA></xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTemplate, _activityHandle, _fieldId, _fieldValue, _sessionToken];
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_sessionToken release]; 
    [_activityHandle release]; 
    [_fieldId release]; 
    [_fieldValue release]; 
    [super dealloc];
}

@end
