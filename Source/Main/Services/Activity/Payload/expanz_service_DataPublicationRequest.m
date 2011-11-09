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
@synthesize useThumbnailImages = _useThumbnailImages;

/* ================================================== Constructors ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _useThumbnailImages = YES;
        _populateMethod = @"ListMe";
        _query = @"";
        _autoPopulate = YES;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSString*) query {
    return [[_query retain] autorelease];
}

- (void) setQuery:(NSString*)query {
    if (query != _query) {
        [_query release];
        _query = [query copy];
        [_populateMethod release];
        _populateMethod = nil;
    }
}


/* ================================================= Protocol Methods =============================================== */

#define kXmlTemplate @"<DataPublication useThumbNailImages=\"%@\" id=\"%@\" populateMethod=\"%@\" query=\"%@\" "\
"autoPopulate=\"%@\"/>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTemplate, _useThumbnailImages == YES ? @"1" : @"0", _dataPublicationId,
                                      _populateMethod != nil ? _populateMethod : @"", _query,
                                      _autoPopulate == YES ? @"1" : @"0"];
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_dataPublicationId release];
    [_populateMethod release];
    [super dealloc];
}


@end