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

#import <Objection-iOS/Objection.h>
#import "JBPackageVoodoo.h"
#import "JBServiceLocator.h"
#import "ASIFormDataRequest.h"


@implementation ex_security_XmlPostLoginClient

objection_register(ex_security_XmlPostLoginClient)





/* ================================================== Constructors ================================================== */

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/* ================================================ Interface Methods =============================================== */



- (ex_security_SessionContextHolder*) createSessionWith:(NSString*)usernName and:(NSString*)password {
//    
//    NSURL *url = [NSURL URLWithString:kAffiliateSummaryReportUrl];    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: url];
//        
//    [request startSynchronous];
//    NSError* error = [request error];
//    if (!error) {
//        NSString* jsonString = [request responseString];                
//        return [JsonAffiliateSummaryDao unmarshalFromJson: jsonString];                
//    }
    return nil;    
}
    

//- (void) listAffiliateSummaryBy:(NSNumber*)siteOid didFinishSelector:(SEL)didFinishSelector 
//                didFailSelector:(SEL)didFailSelector {
//    LogDebug(@"Loading report data");
//    
//}





@end
