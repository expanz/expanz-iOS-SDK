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

#import "JBDependencyBinder.h"
#import "JBPackageVoodoo.h"


@implementation JBDependencyBinder

- (void)configure {
    [self bind:[expanz_service_XmlPostLoginClient loginClient] toProtocol:@protocol(expanz_service_LoginClient)];  
}


@end 
