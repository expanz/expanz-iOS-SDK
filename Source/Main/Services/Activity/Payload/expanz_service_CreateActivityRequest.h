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
#import "expanz_model_ActivityStyle.h"

@class expanz_service_DataPublicationRequest;

@interface expanz_service_CreateActivityRequest : NSObject <xml_Serializable> {

@private
    NSMutableDictionary* _dataPublicationRequests;
}


@property(nonatomic, readonly) NSString* activityName;
@property(nonatomic, readonly) ActivityStyle* style;
@property(nonatomic, readonly) NSString* initialKey;
@property(nonatomic, readonly) NSString* sessionToken;
@property(nonatomic, readonly) NSArray* dataPublicationRequests;


/**
* Initializes with activity name, and session token attribtues.
*/
- (id) initWithActivityName:(NSString*)activityName style:(ActivityStyle*)style initialKey:(NSString*)initialKey
               sessionToken:(NSString*)sessionToken;

/**
* Creates or retrieves a DataPublicationRequest for associated with the supplied UITableView.
*/
- (expanz_service_DataPublicationRequest*) dataPublicationRequestFor:(UITableView*)tableView;


@end

/* ================================================================================================================== */
@compatibility_alias CreateActivityRequest expanz_service_CreateActivityRequest;