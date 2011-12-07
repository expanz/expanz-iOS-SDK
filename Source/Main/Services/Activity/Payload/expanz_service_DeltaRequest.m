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
#import "expanz_model_Field.h"
#import "expanz_model_SessionContext.h"
#import "expanz_model_ActivityInstance.h"

@implementation expanz_service_DeltaRequest

@synthesize sessionToken = _sessionToken;
@synthesize activityHandle = _activityHandle;
@synthesize fieldId = _fieldId;
@synthesize fieldValue = _fieldValue;
@synthesize encoding = _encoding;

/* ================================================= Class Methods ================================================== */
+ (id) forField:(expanz_model_Field*)field {
    NSString* sessionToken = [SessionContext globalContext].sessionToken;
    return [[[DeltaRequest alloc]
        initWithFieldId:field.fieldId fieldValue:field.value activityHandle:field.parentActivity.handle
           sessionToken:sessionToken] autorelease];
}

/* ================================================== Initializers ================================================== */
- (id) initWithFieldId:(NSString*)fieldId fieldValue:(NSString*)fieldValue activityHandle:(NSString*)activityHandle
          sessionToken:(NSString*)sessionToken {

    return [self initWithFieldId:fieldId fieldValue:fieldValue activityHandle:activityHandle sessionToken:sessionToken
                        encoding:DeltaEncodingDefault];

}

- (id) initWithFieldId:(NSString*)fieldId fieldValue:(NSString*)fieldValue activityHandle:(NSString*)activityHandle
          sessionToken:(NSString*)sessionToken encoding:(DeltaEncoding)encoding {

    self = [super init];
    if (self) {
        _fieldId = [fieldId copy];
        _fieldValue = [fieldValue copy];
        _activityHandle = [activityHandle copy];
        _sessionToken = [sessionToken copy];
        _encoding = encoding;
    }
    return self;
}


/* ================================================= Protocol Methods =============================================== */
#define kXmlTemplate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity activityHandle=\"%@\">\
<Delta id=\"%@\" %@ %@>%@</Delta></Activity></ESA></xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    NSString* encodingAttribute = _encoding == DeltaEncodingBase64 ? @"encoding=\"BASE64\"" : @"";
    NSString* valueAttribute = _encoding == DeltaEncodingBase64 ? @"value=\"$longData$\"" :
        [NSString stringWithFormat:@"value=\"%@\"", _fieldValue];
    NSString* base64Packet = _encoding == DeltaEncodingBase64 ? _fieldValue : @"";

    return [NSString stringWithFormat:kXmlTemplate, _activityHandle, _fieldId, encodingAttribute, valueAttribute,
                                      base64Packet, _sessionToken];
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
