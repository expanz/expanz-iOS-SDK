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
#import "expanz_service_XmlPostWebService.h"
#import "expanz_service_FileDownloadClient.h"

@interface expanz_service_XmlPostFileDownloadClient :
    expanz_service_XmlPostWebService<expanz_service_FileDownloadClient>

@end

/* ================================================================================================================== */
@compatibility_alias XmlPostFileDownloadClient expanz_service_XmlPostFileDownloadClient;