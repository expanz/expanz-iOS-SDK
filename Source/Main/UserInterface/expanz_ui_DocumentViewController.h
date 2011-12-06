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
#import "expanz_service_ActivityClient.h"


@interface expanz_ui_DocumentViewController : UIViewController<expanz_service_ActivityClientDelegate> {

@private
    id<expanz_service_ActivityClient> _activityClient;
}

@property (nonatomic, retain) NSString* documentId;
@property (nonatomic, retain) NSString* activityHandle; 
@property (nonatomic, retain) IBOutlet UIWebView* documentView;

- (id) initWithDocumentId:(NSString*)documentId activityHandle:(NSString*)activityHandle;

@end

/* ================================================================================================================== */
@compatibility_alias DocumentViewController expanz_ui_DocumentViewController;