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
    [self bind:[ex_security_XmlPostLoginClient loginClient] toProtocol:@protocol(ex_security_LoginClient)];  
}


@end 
