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
#import "expanz_model_AppSite.h"


@implementation expanz_model_AppSite

@synthesize appSiteId = _appSiteId;
@synthesize name = _name;
@synthesize authenticationMode = _authenticationMode;

/* ================================================== Initializers ================================================== */
- (id) initWithAppSiteId:(NSString*)appSiteId name:(NSString*)name authenticationMode:(NSString*)authenticationMode {
    self = [super init];
    if (self) {
        _appSiteId = [appSiteId copy];
        _name = [name copy];
        _authenticationMode = [authenticationMode copy];
    }
    return self;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"AppSite: appSiteId=%@, name=%@, authenticationMode=%@", _appSiteId, _name,
                                      _authenticationMode];
}


@end