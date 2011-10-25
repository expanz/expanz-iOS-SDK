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
@class expanz_model_ActivityInstance;
@class expanz_model_Field;
@class expanz_ui_ActivityInstanceViewController;

@interface expanz_ui_ModelAdapter : NSObject {
    
@private    
    NSMutableDictionary* _fieldMappings;
    
}

@property (nonatomic, readonly) expanz_model_ActivityInstance* activityInstance; 


- (id) initWithViewController:(expanz_ui_ActivityInstanceViewController*)viewController;

- (UIControl*) textControlFor:(expanz_model_Field*)field; 
- (expanz_model_Field*) fieldFor:(UIControl*)control;
- (void) updateUIControlsWithModelValues; 


@end

/* ================================================================================================================== */
@compatibility_alias ModelAdapter expanz_ui_ModelAdapter;