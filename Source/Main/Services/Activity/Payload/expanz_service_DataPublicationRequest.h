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


@interface expanz_service_DataPublicationRequest : NSObject<xml_Serializable> {
    NSString* _dataPublicationId;
    NSString* _populateMethod;
    NSString* _query;
    BOOL _autoPopulate;
}

@property(nonatomic, retain) NSString* dataPublicationId;
@property(nonatomic, retain) NSString* populateMethod;
@property(nonatomic, retain) NSString* query;
@property(nonatomic) BOOL autoPopulate;


@end

/* ================================================================================================================== */
@compatibility_alias DataPublicationRequest expanz_service_DataPublicationRequest;