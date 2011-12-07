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
#import "expanz_service_FileDownloadRequest.h"
#import "expanz_model_SessionContext.h"


@implementation expanz_service_FileDownloadRequest

@synthesize blobId = _blobId;
@synthesize isByteArray = _isByteArray;
@synthesize activityHandle = _activityHandle;
@synthesize sessionToken = _sessionToken;

/* ================================================= Class Methods ================================================== */
+ (id) withBlobId:(NSString*)blobId isByteArray:(BOOL)isByteArray activityHandle:(NSString*)activityHandle {
    return [[FileDownloadRequest alloc] initWithBlobId:blobId isByteArray:isByteArray activityHandle:activityHandle
                                          sessionToken:[SessionContext globalContext].sessionToken];
}


/* ================================================== Initializers ================================================== */
- (id) initWithBlobId:(NSString*)blobId isByteArray:(BOOL)isByteArray activityHandle:(NSString*)activityHandle
         sessionToken:(NSString*)sessionToken {

    self = [super init];
    if (self) {
        _blobId = [blobId copy];
        _isByteArray = isByteArray;
        _activityHandle = [activityHandle copy];
        _sessionToken = [sessionToken copy];
    }
    return self;

}

/* ================================================= Protocol Methods =============================================== */

#define kXmlTemplate @"<GetBlob xmlns=\"http://www.expanz.com/ESAService\"><sessionHandle>%@</sessionHandle>\
<activityHandle>%@</activityHandle><blobId>%@</blobId><isbyteArray>%@</isbyteArray></GetBlob>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTemplate, _sessionToken, _activityHandle, _blobId,
                                      _isByteArray == YES ? @"true" : @"false"];

}



/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_blobId release];
    [_activityHandle release];
    [_sessionToken release];
    [super dealloc];
}

@end