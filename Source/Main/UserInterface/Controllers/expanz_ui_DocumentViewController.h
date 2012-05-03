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
#import "ExpanzFileDownloadClient.h"


@protocol ExpanzFileDownloadClient;
@class MBProgressHUD;


@interface expanz_ui_DocumentViewController : UIViewController<ExpanzFileDownloadClientDelegate,
    UIPrintInteractionControllerDelegate> {

@private
    MBProgressHUD* _loadingHud;
    id<ExpanzFileDownloadClient> _fileDownloadClient;
}


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