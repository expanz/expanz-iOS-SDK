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

@interface expanz_model_Activity : NSObject {

@protected
    NSString* _title; 
    
}

@property (nonatomic, readonly) NSString* name; 
@property (nonatomic, readonly) NSString* title; 

- (id) initWithName:(NSString*)name andTitle:(NSString*)title; 

@end

/* ================================================================================================================== */
@compatibility_alias Activity expanz_model_Activity;
