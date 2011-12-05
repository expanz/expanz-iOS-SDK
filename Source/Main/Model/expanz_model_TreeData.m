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
#import "expanz_model_TreeData.h"
#import "expanz_model_Folder.h"
#import "expanz_ui_TreeDataRenderer.h"


@implementation expanz_model_TreeData

/* ================================================== Constructors ================================================== */
- (id)initWithDataId:(NSString*)dataId {
    self = [super initWithDataId:dataId];
    if (self) {
        _folders = [[NSMutableArray alloc] init];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (NSArray*)folders {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"sequence" ascending:YES];
    return [_folders sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}


- (void)addFolder:(expanz_model_Folder*)folder {
    [_folders addObject:folder];
}

/* ================================================= Protocol Methods =============================================== */
- (expanz_ui_AbstractDataRenderer*)withDataRendererFor:(UITableView*)tableView activityName:(NSString*)activityName {
    return [[[TreeDataRenderer alloc] initWithData:self tableView:tableView activityName:activityName] autorelease];
}

/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_folders release];
    [super dealloc];
}


@end