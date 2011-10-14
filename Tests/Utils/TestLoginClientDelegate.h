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
#import "expanz_service_LoginClient.h"

@interface TestLoginClientDelegate : NSObject<expanz_service_LoginClientDelegate>

@property (nonatomic, retain) SessionContext* sessionContext;
@property (nonatomic, retain) NSError* error; 

@end
