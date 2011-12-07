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


#import "expanz_model_ImageCell.h"
#import "ASIHTTPRequest.h"


@implementation expanz_model_ImageCell

@synthesize imageUrl = _imageUrl;
@synthesize image = _image;
@synthesize hasAskedImageToLoad = _hasAskedImageToLoad;

/* ================================================== Initializers ================================================== */
- (id) initWithCellId:(NSString*)cellId imageUrl:(NSString*)imageUrl {
    self = [super initWithCellId:cellId];
    if (self) {
        _imageUrl = [imageUrl copy];
        [self loadImage];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) loadImage {
    [self setHasAskedImageToLoad:YES];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:_imageUrl]];
    [request setCompletionBlock:^{
            self.image = [[UIImage imageWithData:[request responseData]] retain];
        }];

    [request setFailedBlock:^{
            //TODO: Handle this?
            LogError(@"Can't download the image: %@", _imageUrl);
        }];
    [request startAsynchronous];
}


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_imageUrl release];
    [_image release];
    [super dealloc];
}


@end