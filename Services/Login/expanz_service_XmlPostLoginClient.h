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

#import <Foundation/Foundation.h>
#import "JBPackageVoodoo.h"
#import "ASIFormDataRequest.h"


/* ================================================================================================================== */
@interface expanz_service_XmlPostLoginClient : NSObject<expanz_service_LoginClient>


@property (nonatomic, readonly) ASIFormDataRequest* loginRequest;

- (id) initWithLoginRequest:(ASIFormDataRequest*)loginRequest;

@end


