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


@interface expanz_model_AppSite : NSObject

@property(nonatomic, strong, readonly) NSString* appSiteId;
@property(nonatomic, strong, readonly) NSString* name;
@property(nonatomic, strong, readonly) NSString* authenticationMode;

- (id) initWithAppSiteId:(NSString*)appSiteId name:(NSString*)name authenticationMode:(NSString*)authenticationMode;


@end
/* ================================================================================================================== */
@compatibility_alias AppSite expanz_model_AppSite;