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
#import "UIView+ModelAdapter.h"
#import "expanz_ui_ModelAdapter.h"


@implementation UIView (ModelAdapter)

- (NSString*) fieldIdInModelAdapter:(expanz_ui_ModelAdapter*)modelAdapter {
    return nil;
}

@end

/* ================================================================================================================== */
@implementation UILabel (ModelAdapter)

- (NSString*) fieldIdInModelAdapter:(expanz_ui_ModelAdapter*)modelAdapter {
    return [[[modelAdapter valueForKey:@"_labelMappings"] allKeysForObject:self] objectAtIndex:0];
}

@end


/* ================================================================================================================== */
@implementation UITextField (ModelAdapter)

- (NSString*) fieldIdInModelAdapter:(expanz_ui_ModelAdapter*)modelAdapter {
    LogDebug(@"Let's get the field then!!!");
    LogDebug(@"%@", [modelAdapter valueForKey:@"_textFieldMappings"]);
    LogDebug(@"%p", self);
    return [[[modelAdapter valueForKey:@"_textFieldMappings"] allKeysForObject:self] objectAtIndex:0];
}

@end


/* ================================================================================================================== */
@implementation UIImageView (ModelAdapter)

- (NSString*) fieldIdInModelAdapter:(expanz_ui_ModelAdapter*)modelAdapter {
    return [[[modelAdapter valueForKey:@"_imageFieldMappings"] allKeysForObject:self] objectAtIndex:0];
}

@end


/* ================================================================================================================== */
@implementation UITableView (ModelAdapter)

- (NSString*) fieldIdInModelAdapter:(expanz_ui_ModelAdapter*)modelAdapter {
    return [[[modelAdapter valueForKey:@"_tableViewMappings"] allKeysForObject:self] objectAtIndex:0];
}

@end

