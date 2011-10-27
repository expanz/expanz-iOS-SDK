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


@interface expanz_model_DataPublication : NSObject

@property(nonatomic, readonly) NSString* dataPublicationId;
@property(nonatomic, readonly) NSString* populateMethod;
@property(nonatomic, readonly) BOOL autoPopulate;


- (id) initWithId:(NSString*)dataPublicationId populateMethod:(NSString*)populateMethod autoPopulate:(BOOL)autoPopulate;

@end