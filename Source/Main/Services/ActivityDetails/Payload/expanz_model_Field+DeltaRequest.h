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

#import "expanz_model_Field.h"
@class expanz_service_DeltaRequest; 


@interface expanz_model_Field (DeltaRequest)

- (expanz_service_DeltaRequest*) asDeltaRequest;

@end
