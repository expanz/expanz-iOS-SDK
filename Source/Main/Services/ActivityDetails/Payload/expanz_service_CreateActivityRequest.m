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

#import "expanz_service_CreateActivityRequest.h"
#import "expanz_iOS_SDKExceptions.h"

@implementation expanz_service_CreateActivityRequest

@synthesize activityName = _activityName;
@synthesize style = _style;
@synthesize sessionToken = _sessionToken;

/* ================================================== Constructors ================================================== */

- (id) initWithActivityName:(NSString*)activityName style:(NSString*)style sessionToken:(NSString*)sessionToken {
    self = [super init];
    if (self) {
        _activityName = [activityName retain];
        if (style != nil) {
            _style = [style retain];
        }
        else {
            _style = @"";
        }
        _sessionToken = [sessionToken retain];
    }
    return self;
}

/* ================================================= Protocol Methods =============================================== */
#pragma mark xml_Serializable


#define kXmlTempate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA>\
<CreateActivity name=\"%@\" style=\"%@\"/></ESA>\
</xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTempate, _activityName, _style, _sessionToken];
}

/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_activityName release];
    [_style release];
    [_sessionToken release];
    [super dealloc];
}

@end
