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
#import "xml_Serializable.h"


@interface expanz_service_SessionDataRequest : NSObject<xml_Serializable>



@property (nonatomic, readonly) NSString* sessionToken;

- (id) initWithSessionToken:(NSString*)sessionToken; 

@end

/* ================================================================================================================== */
@compatibility_alias SessionDataRequest expanz_service_SessionDataRequest;