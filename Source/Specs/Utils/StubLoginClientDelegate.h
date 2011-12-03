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
@class expanz_model_SessionContext;

@interface StubLoginClientDelegate : NSObject<expanz_service_LoginClientDelegate>

@property (nonatomic, retain) expanz_model_SessionContext* sessionContext;
@property (nonatomic, retain) NSError* error; 

@end
