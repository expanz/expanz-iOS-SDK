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

#import "RXMLElement.h"
@class expanz_model_ActivityInstance;
@class expanz_model_FieldInstance;
@class expanz_model_Message;
@class expanz_model_GridData;
@class expanz_model_Column;
@class expanz_model_Row;
@class expanz_model_TextGridDataCell;
@class expanz_model_Folder;
@class expanz_model_File;
@class expanz_model_FileResource;

/**
 * Adds methods to RXMLElement for parsing results of XmlPostActivityClient invocations. 
 */
@interface RXMLElement (ActivityInstance)

/**
* Maps the element onto an `expanz_model_ActivityInstance` object.
*/
- (expanz_model_ActivityInstance*) asActivityInstance;

/**
* Maps the element onto an `expanz_model_Field` object.
*/
- (expanz_model_FieldInstance*) asFieldInstance;

/**
* Maps the element onto an `expanz_model_Message` object.
*/
- (expanz_model_Message*) asMessage;

/**
* Maps the element onto an `expanz_model_DataSet` object.
*/
- (expanz_model_GridData*) asData;

/**
* Maps the element onto an `expanz_model_Column` object.
*/
- (expanz_model_Column*) asColumn;

/**
* Maps the element onto an `expanz_model_Row` object.
*/
- (expanz_model_Row*) asRow;

/**
* Maps the element onto an `expanz_model_Folder` object.
*/
- (expanz_model_Folder*) asFolder;

/**
* Maps the elements onto an `expanz_model_File` object.
*/
- (expanz_model_File*) asFile;


@end
