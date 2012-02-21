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
@class expanz_model_AppSite;


@interface expanz_model_SiteList : NSObject {
    
@private 
    NSMutableArray* _sites; 
}

- (NSArray*) sites;

- (void) addSite:(expanz_model_AppSite*)site; 


@end
/* ================================================================================================================== */
@compatibility_alias SiteList expanz_model_SiteList;