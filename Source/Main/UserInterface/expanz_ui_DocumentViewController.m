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
#import <Objection-iOS/JSObjection.h>
#import "expanz_ui_DocumentViewController.h"
#import "expanz_service_FileRequest.h"


@implementation expanz_ui_DocumentViewController

@synthesize documentView = _documentView;
@synthesize documentId = _documentId;
@synthesize activityHandle = _activityHandle;

- (id) initWithDocumentId:(NSString*)documentId activityHandle:(NSString*)activityHandle {
    self = [super initWithNibName:@"DocumentView" bundle:[NSBundle mainBundle]];
    if (self) {
        _documentId = [documentId copy];
        _activityHandle = [activityHandle copy];
        _activityClient = [[[JSObjection globalInjector] getObject:@protocol(expanz_service_ActivityClient)] retain];
    }
    return self;
}



/* ================================================== Constructors ================================================== */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    LogDebug(@"Loading document. . . . ");
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"doc"];
    NSURL* url = [NSURL fileURLWithPath:path];
    LogDebug("URL: %@", url);
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_documentView loadRequest:request];
}


/* ================================================ Interface Methods =============================================== */
- (void) viewDidLoad {
    [super viewDidLoad];
    FileRequest* fileRequest = [FileRequest forFileId:_documentId activityHandle:_activityHandle];
    [_activityClient sendFileRequestWith:fileRequest delegate:self];
}


/* ================================================= Protocol Methods =============================================== */
- (void) requestDidFinishWithActivityInstance:(expanz_model_ActivityInstance*)activityInstance {
    LogDebug(@"Got response");

}

- (void) requestDidFailWithError:(NSError*)error {
    //To change the template use AppCode | Preferences | File Templates.

}


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_documentView release];
    [_documentId release];
    [_activityHandle release];
    [_activityClient release];
    [super dealloc];
}

@end