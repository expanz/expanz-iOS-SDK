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
#import "expanz_ui_QueryDataSource.h"
#import <objc/runtime.h>

@implementation expanz_ui_QueryDataSource

/* ================================================= Class Methods ================================================== */
+ (BOOL) resolveInstanceMethod:(SEL)sel {
    NSString* name = NSStringFromSelector(sel);
    if ([name hasPrefix:@"set"]) {
        IMP imp = imp_implementationWithBlock((void*) objc_unretainedPointer(^(id me, BOOL selected) {
            NSString* fieldName = [name substringFromIndex:3];
            fieldName = [fieldName substringToIndex:[fieldName length] - 1];
            NSMutableDictionary* cache = [me performSelector:@selector(cache)];
            [cache setObject:[NSNumber numberWithBool:selected] forKey:fieldName];
        }));
        class_addMethod(self, sel, imp, "v@:c");
        return YES;
    }
    return NO;
}

/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _cache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSString*) query {
    __block NSMutableArray* queries = [[NSMutableArray alloc] init];
    [_cache enumerateKeysAndObjectsUsingBlock:(^(NSString* key, NSNumber* value, BOOL* stop) {
        if ([value boolValue] == YES) {
            [queries addObject:key];
        }
    })];
    if ([queries count] > 1) {
        [NSException raise:NSInvalidArgumentException
                format:@"Expected QueryDataSource to have one query, but instead got: %@", queries];
    }
    NSString* codeFormattedQuery = [queries objectAtIndex:0];
    return [codeFormattedQuery stringByReplacingOccurrencesOfString:@"_" withString:@"."];
}

/* ================================================================================================================== */
- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}


- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/* ================================================== Private Methods =============================================== */
- (NSMutableDictionary*) cache {
    return _cache;
}

@end