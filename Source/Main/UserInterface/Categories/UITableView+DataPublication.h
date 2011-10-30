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

@interface UITableView (DataPublication)

- (void) setDataPublicationId:(NSString*)dataPublicationId;
- (void) setPopulateMethod:(NSString*)populateMethod;
- (void) setAutoPopulate:(BOOL)autoPopulate;

@end