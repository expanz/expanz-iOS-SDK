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

#import <QuartzCore/QuartzCore.h>
#import "UIButton+ExpanzTextures.h"

@implementation UIButton (ExpanzTextures)

- (void) setGlossy:(BOOL)glossy {
    CALayer* layer = self.layer;
    layer.cornerRadius = 8.0f;
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0f;
    layer.borderColor = [UIColor colorWithWhite:0.5f alpha:0.2f].CGColor;

    CAGradientLayer* shineLayer = [CAGradientLayer layer];
    shineLayer.frame = layer.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:(__bridge id) [UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                                                  (__bridge id) [UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                                                  (__bridge id) [UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                                                  (__bridge id) [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                                                  (__bridge id) [UIColor colorWithWhite:1.0f alpha:0.4f].CGColor, nil];
    shineLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.5f],
                                                     [NSNumber numberWithFloat:0.55f], [NSNumber numberWithFloat:0.8f],
                                                     [NSNumber numberWithFloat:1.0f], nil];
    [layer addSublayer:shineLayer];
}



@end