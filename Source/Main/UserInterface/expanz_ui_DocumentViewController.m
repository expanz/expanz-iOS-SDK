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
#import "Objection.h"
#import "expanz_model_FileResource.h"
#import "expanz_model_ResourceCollection.h"
#import "expanz_service_FileRequest.h"
#import "expanz_service_FileDownloadClient.h"
#import "expanz_service_FileDownloadRequest.h"
#import "expanz_ui_DocumentViewController.h"


@implementation expanz_ui_DocumentViewController

@synthesize spinner = _spinner;
@synthesize documentView = _documentView;
@synthesize printButton = _printButton;
@synthesize documentId = _documentId;
@synthesize activityHandle = _activityHandle;
@synthesize ext = _ext;

/* ================================================== Initializers ================================================== */
- (id) initWithDocumentId:(NSString*)documentId activityHandle:(NSString*)activityHandle {
    self = [super initWithNibName:@"DocumentView" bundle:[NSBundle mainBundle]];
    if (self) {
        _documentId = [documentId copy];
        _activityHandle = [activityHandle copy];
        _fileDownloadClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_FileDownloadClient)];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_spinner startAnimating];
    FileRequest* fileRequest = [FileRequest forFileId:_documentId activityHandle:_activityHandle];
    [_fileDownloadClient sendFileRequestWith:fileRequest delegate:self];
    [_documentView setHidden:YES];
}

- (IBAction) print {
    UIPrintInteractionController* pic = [UIPrintInteractionController sharedPrintController];
    //pic.delegate = self;

    UIPrintInfo* printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = self.title;
    pic.printInfo = printInfo;

    pic.printFormatter = [_documentView viewPrintFormatter];
    pic.showsPageRange = YES;

    void(^completionHandler)(UIPrintInteractionController*, BOOL, NSError*) =
        ^(UIPrintInteractionController* printController, BOOL completed, NSError* error) {
            if (!completed && error) {
                NSLog(@"Printing could not complete because of error: %@", error);
            }
        };

    [pic presentAnimated:YES completionHandler:completionHandler];


}

/* ================================================= Protocol Methods =============================================== */
- (void) requestDidFinishWithResourceCollection:(expanz_model_ResourceCollection*)collection {
    //TODO: Support pages with multiple documents in a collection.
    FileResource* fileResource = [[collection fileResources] objectAtIndex:0];

    LogDebug(@"Document Title: %@", collection.title);
    LogDebug(@"File resource: %@", fileResource);
    self.title = collection.title;
    self.ext = fileResource.ext;

    FileDownloadRequest* request =
        [FileDownloadRequest withBlobId:fileResource.field isByteArray:NO activityHandle:_activityHandle];
    [_fileDownloadClient downloadFileWith:request delegate:self];

}

- (void) requestDidFinishWithData:(NSData*)data {
    [_spinner stopAnimating];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fileName = [@"current-document" stringByAppendingString:self.ext];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    [data writeToFile:filePath atomically:YES];
    LogDebug(@"Loading document. . . . ");
    NSURL* url = [NSURL fileURLWithPath:filePath];
    LogDebug("URL: %@", url);
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_documentView loadRequest:request];
    [_documentView setHidden:NO];
}

- (void) requestDidFailWithError:(NSError*)error {


}


@end