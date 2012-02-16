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
#import "RXMLElement+ResourceCollection.h"
#import "../../../Assembly/expanz_ios_SdkExceptions.h"
#import "expanz_model_FileResource.h"
#import "expanz_model_ResourceCollection.h"


@implementation RXMLElement (ResourceCollection)


- (ResourceCollection*) asResourceCollectionWithTitle:(NSString*)title {
    if (![self.tag isEqualToString:@"Files"]) {
        [NSException raise:ExXmlValidationException format:@"Element name is not Files."];
    }
    ResourceCollection* collection = [[ResourceCollection alloc] initWithTitle:title];

    [self iterate:@"*" with:^(RXMLElement* e) {
        [collection addFileResource:[e asFileResource]];
    }];

    return collection;
}

- (FileResource*) asFileResource {
    if (![self.tag isEqualToString:@"File"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a File."];
    }
    return [[FileResource alloc]
        initWithPath:[self attribute:@"path"] ext:[self attribute:@"ext"] field:[self attribute:@"field"]];

}


@end