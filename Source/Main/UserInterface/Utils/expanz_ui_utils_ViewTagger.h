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


@interface expanz_ui_utils_ViewTagger : NSObject

/**
* If the view already has a tag allocated, returns the existing tag, otherwise creates a unique one.
*/
+ (NSUInteger) tagForView:(UIView*)view;

@end
/* ================================================================================================================== */
@compatibility_alias ViewTagger expanz_ui_utils_ViewTagger;