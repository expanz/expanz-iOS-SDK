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
#import "expanz_ui_DocumentViewController.h"


@implementation expanz_ui_DocumentViewController

@synthesize documentView = _documentView;


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    LogDebug(@"Loading document. . . . ");
    NSString* path = [[NSBundle mainBundle] pathForResource:@"cv-jasper" ofType:@"doc"];
    NSURL* url = [NSURL fileURLWithPath:path];
    LogDebug("URL: %@", url);
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_documentView loadRequest:request];
}



/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_documentView release];
    [super dealloc];
}

@end