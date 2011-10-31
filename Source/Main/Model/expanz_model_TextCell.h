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
* Represents a cell belonging to an `expanz_model_Row`.
*/
@interface expanz_model_TextCell : NSObject {

}

@property (nonatomic, readonly) NSString* cellId;
@property (nonatomic, readonly) NSString* data;

@end

/* ================================================================================================================== */
@compatibility_alias TextCell expanz_model_TextCell;