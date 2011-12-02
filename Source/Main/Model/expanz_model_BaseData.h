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


/**
* Top level container for holding repeating records of information in an `expanz_model_ActivityInstance`. This class
* is not intended to be instantiated directly.
*/
@interface expanz_model_BaseData : NSObject

@property (nonatomic, readonly) NSString* dataId;

- (id) initWithDataId:(NSString*)dataId;

@end

/* ================================================================================================================== */
@compatibility_alias BaseData expanz_model_BaseData;