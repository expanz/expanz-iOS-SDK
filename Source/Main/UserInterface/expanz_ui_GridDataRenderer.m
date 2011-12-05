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

#import "expanz_ui_GridDataRenderer.h"
#import "expanz_ui_components_ThumbnailTableCell.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextCell.h"
#import "expanz_model_ImageCell.h"
#import "expanz_model_ActivityDefinition.h"
#import "expanz_ui_ActivityManager.h"


@implementation expanz_ui_GridDataRenderer

@synthesize gridData = _gridData;
@synthesize tableView = _tableView;
@synthesize activityName = _activityName;
@synthesize tableCell = _tableCell;

/* ================================================== Constructors ================================================== */
- (id)initWithGridData:(GridData*)gridData tableView:(UITableView*)tableView activityName:(NSString*)activityName {
    self = [super init];
    if (self) {
        _gridData = gridData;
        _tableView = tableView;
        _activityName = [activityName copy];
        _activityManager = [[JSObjection globalInjector] getObject:[ActivityManager class]];
    }
    return self;
}

/* ================================================= Protocol Methods =============================================== */

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [_gridData.rows count];
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    NSString* reuseId = [_gridData dataId];

    ThumbnailTableCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TableCell2" owner:self options:nil];
        cell = self.tableCell;
        self.tableCell = nil;
    }

    Row* row = [_gridData.rows objectAtIndex:indexPath.row];
    TextCell* nameCell = (TextCell*) [row cellWithId:@"2"];
    TextCell* phoneCell = (TextCell*) [row cellWithId:@"4"];

    ImageCell* imageCell = (ImageCell*) [row cellWithId:@"1"];
    if (imageCell.hasAskedImageToLoad == NO) {
        [imageCell loadImage];
    }
    [imageCell addObserver:self forKeyPath:@"image" options:0 context:nil];

    cell.mainLabel.text = nameCell.text;
    cell.subLabel.text = phoneCell.text;
    cell.thumbnail.image = imageCell.image;
    cell.backgroundView.backgroundColor =
        (indexPath.row % 2) ? [UIColor colorWithRed:0.942 green:0.942 blue:0.942 alpha:1] :
            [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1];

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    Row* row = [_gridData.rows objectAtIndex:indexPath.row];

    ActivityDefinition* edit =
        [[ActivityDefinition alloc] initWithName:_activityName title:@"Edit" style:[ActivityStyle defaultStyle]];
    if ([_activityManager transitionToActivityWithDefinition:edit initialKey:row.rowId]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 75;
}

/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_activityName release];
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change
                       context:(void*)context {
    [_tableView reloadData];
    [_tableView setNeedsLayout];
}


@end