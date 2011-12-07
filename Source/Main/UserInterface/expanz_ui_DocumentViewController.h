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
#import "expanz_service_FileDownloadClientDelegate.h"

@protocol expanz_service_FileDownloadClient;


@interface expanz_ui_DocumentViewController : UIViewController<expanz_service_FileDownloadClientDelegate,
    UIPrintInteractionControllerDelegate> {

@private
    id<expanz_service_FileDownloadClient> _fileDownloadClient;
}


@property(nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner;
@property(nonatomic, retain) IBOutlet UIWebView* documentView;
@property(nonatomic, retain) IBOutlet UIBarButtonItem* printButton;
@property(nonatomic, retain) NSString* documentId;
@property(nonatomic, retain) NSString* activityHandle;
@property(nonatomic, retain) NSString* ext;

- (id) initWithDocumentId:(NSString*)documentId activityHandle:(NSString*)activityHandle;

- (IBAction) print;

@end

/* ================================================================================================================== */
@compatibility_alias DocumentViewController expanz_ui_DocumentViewController;