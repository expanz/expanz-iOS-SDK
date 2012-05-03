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

#import "expanz_model_SessionData.h"
#import "expanz_model_Menu.h"


@implementation expanz_model_SessionData

@synthesize operationalMode = _operationalMode;
@synthesize timeZone = _timeZone;
@synthesize blobCacheUrl = _blobCacheUrl;
@synthesize userCultureName = _userCultureName;
@synthesize menu = _menu;

/* ================================================== Initializers ================================================== */
- (id) initWithOperationalMode:(NSString*)operationalMode timeZone:(NSString*)timeZone
        blobCacheUrl:(NSString*)blobCacheUrl userCultureName:(NSString*)userCultureName
        menu:(expanz_model_Menu*)menu {

    self = [super init];
    if (self) {
        _operationalMode = operationalMode;
        _timeZone = timeZone;
        _blobCacheUrl = blobCacheUrl;
        _userCultureName = userCultureName;
        _menu = menu;
    }
    return self;
}





@end