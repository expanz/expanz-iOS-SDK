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

#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_SessionContext.h"

@implementation expanz_service_MethodInvocationRequest

@synthesize activityInstance = _activityInstance;
@synthesize methodName = _methodName;

/* ================================================== Constructors ================================================== */
- (id) initWithActivityInstance:(expanz_model_ActivityInstance*)activityInstance methodName:(NSString*)methodName {
    self = [super init]; 
    if (self) {
        _activityInstance = [activityInstance retain]; 
        _methodName = [methodName retain];
    }
    return self;
}


/* ================================================= Protocol Methods =============================================== */
#define kXmlTemplate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity activityHandle=\"%@\">\
<Method name=\"%@\"/></Activity></ESA></xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    NSString* sessionToken = [SessionContext globalContext].sessionToken;
    return [NSString stringWithFormat:kXmlTemplate, _activityInstance.handle, _methodName, sessionToken];
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_activityInstance release]; 
    [_methodName release];
    [super dealloc];
}

@end
