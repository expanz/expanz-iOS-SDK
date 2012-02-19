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

#import "expanz_model_SessionContext.h"
#import "expanz_service_FileRequest.h"


@implementation expanz_service_FileRequest

@synthesize fileId = _fileId;
@synthesize activityHandle = _activityHandle;
@synthesize sessionToken = _sessionToken;

/* ================================================= Class Methods ================================================== */
+ (id)forFileId:(NSString*)fileId activityHandle:(NSString*)activityHandle {
    return [[FileRequest alloc]
        initWithFileId:fileId activityHandle:activityHandle sessionToken:[SessionContext globalContext].sessionToken];
}

/* ================================================== Initializers ================================================== */
- (id)initWithFileId:(NSString*)fileId activityHandle:(NSString*)activityHandle sessionToken:(NSString*)sessionToken {
    self = [super init];
    if (self) {
        _fileId = [fileId copy];
        _activityHandle = [activityHandle copy];
        _sessionToken = [sessionToken copy];
    }
    return self;
}

/* ================================================= Protocol Methods =============================================== */
#define kXmlTemplate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity activityHandle=\"%@\">\
<Context id=\"%@\" Type=\"\" contextObject=\"File\"/><MenuAction defaultAction=\"1\" contextObject=\"File\"/>\
</Activity></ESA></xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*)toXml {
    return [NSString stringWithFormat:kXmlTemplate, _activityHandle, _fileId, _sessionToken];
}



@end