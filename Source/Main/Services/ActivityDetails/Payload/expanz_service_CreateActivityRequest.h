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

@class expanz_service_DataPublicationRequest;

@interface expanz_service_CreateActivityRequest : NSObject <xml_Serializable>


@property(nonatomic, readonly) NSString* activityName;
@property(nonatomic, readonly) NSString* style;
@property(nonatomic, readonly) NSString* sessionToken;
@property(nonatomic, readonly) NSMutableArray* dataPublicationRequests;


- (id) initWithActivityName:(NSString*)activityName style:(NSString*)style sessionToken:(NSString*)sessionToken;

- (void) addDataPublicationRequest:(expanz_service_DataPublicationRequest*)dataPublicationRequest;


@end

/* ================================================================================================================== */
@compatibility_alias CreateActivityRequest expanz_service_CreateActivityRequest;