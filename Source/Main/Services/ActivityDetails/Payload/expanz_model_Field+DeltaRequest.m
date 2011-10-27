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

#import "expanz_model_SessionContext.h"
#import "expanz_model_Field+DeltaRequest.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_model_ActivityInstance.h"


@implementation expanz_model_Field (DeltaRequest)

- (DeltaRequest*) asDeltaRequest {
    NSString* sessionToken = [SessionContext globalContext].sessionToken; 
    return [[[DeltaRequest alloc] initWithFieldId:self.fieldId fieldValue:self.value 
                                  activityHandle:self.parentActivity.handle sessionToken:sessionToken] autorelease];
    
}

@end
