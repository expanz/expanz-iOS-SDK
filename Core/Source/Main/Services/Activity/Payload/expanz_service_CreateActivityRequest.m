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
#import "expanz_service_DataPublicationRequest.h"

@implementation expanz_service_CreateActivityRequest

@synthesize activityName = _activityName;
@synthesize style = _style;
@synthesize initialKey = _initialKey;
@synthesize sessionToken = _sessionToken;

/* ================================================== Constructors ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _dataPublicationRequests = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id) initWithActivityName:(NSString*)activityName style:(ExpanzActivityStyle)style initialKey:(NSString*)initialKey
               sessionToken:(NSString*)sessionToken {
    self = [self init];
    _activityName = [activityName copy];
    _style = style;
    _initialKey = [initialKey copy];
    _sessionToken = [sessionToken copy];
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (NSArray*) dataPublicationRequests {
    return [_dataPublicationRequests allValues];
}

- (expanz_service_DataPublicationRequest*) dataPublicationRequestFor:(UITableView*)tableView {
    NSValue* key = [NSValue valueWithPointer:tableView];
    DataPublicationRequest* publicationRequest = [_dataPublicationRequests objectForKey:key];
    if (publicationRequest == nil) {
        publicationRequest = [[DataPublicationRequest alloc] init];
        [_dataPublicationRequests setObject:publicationRequest forKey:key];
        [publicationRequest release];
    }
    return publicationRequest;
}

/* ================================================= Protocol Methods =============================================== */
#pragma mark xml_Serializable

#define kXmlTempate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><CreateActivity name=\"%@\" %@ %@>\
%@</CreateActivity></ESA></xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    NSString* styleAttribute = _style == ActivityStyleBrowse ? @"style=\"browse\"" : @"";
    NSString* initialKeyAttribute =
        _initialKey != nil ? [NSString stringWithFormat:@"initialKey=\"%@\"", _initialKey] : @"";

    NSMutableString* body = [[NSMutableString alloc] initWithString:@""];
    for (DataPublicationRequest* dataPublicationRequest in [_dataPublicationRequests allValues]) {
        [body appendString:[dataPublicationRequest toXml]];
    }
    return [NSString stringWithFormat:kXmlTempate, _activityName, styleAttribute, initialKeyAttribute, body,
                                      _sessionToken];
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_activityName release];
    [_sessionToken release];
    [_dataPublicationRequests release];
    [super dealloc];
}

@end
