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

@protocol expanz_service_FileDownloadClientDelegate

- (void) requestDidFinishWithData:(NSData*)data;
- (void) requestDidFailWithError:(NSError*)error;

@end