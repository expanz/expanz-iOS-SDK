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


#import "expanz_model_DataPublication.h"


@implementation expanz_model_DataPublication

@synthesize dataPublicationId = _dataPublicationId;
@synthesize populateMethod = _populateMethod;
@synthesize autoPopulate = _autoPopulate;

/* ================================================== Constructors ================================================== */
- (id) initWithId:(NSString*)dataPublicationId populateMethod:(NSString*)populateMethod autoPopulate:(BOOL)autoPopulate
{
    return nil;
    //To change the template use AppCode | Preferences | File Templates.

}



/* ================================================== Utility Methods =============================================== */
- (void) dealloc
{
    [_dataPublicationId release];
    [_populateMethod release];
    [super dealloc];
}


@end