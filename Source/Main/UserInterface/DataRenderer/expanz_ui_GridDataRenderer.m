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
#import "expanz_model_TextGridDataCell.h"
#import "expanz_model_ImageGridDataCell.h"
#import "expanz_model_ActivityMenuItem.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_model_GridData.h"
#import "UITableView+DataPublication.h"


@interface expanz_ui_GridDataRenderer (private)

- (void) populateCel:(ThumbnailTableCell*)cell withDataFrom:(AbstractGridDataCell*)abstractCell;

@end
/* ================================================================================================================== */

@implementation expanz_ui_GridDataRenderer

@synthesize tableCell = _tableCell;

/* ================================================== Initializers ================================================== */
- (id) initWithData:(expanz_model_AbstractData*)data tableView:(UITableView*)tableView
       activityName:(NSString*)activityName {

    self = [super initWithData:data tableView:tableView activityName:activityName];
    if (self) {
        _gridData = (GridData*) self.data;
        _observedCells = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================= Protocol Methods =============================================== */
- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [_gridData.rows count];
}


- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    NSString* reuseId = [_gridData dataId];

    ThumbnailTableCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TableCellForGridData" owner:self options:nil];
        cell = self.tableCell;
        self.tableCell = nil;
    }
    cell.thumbnail.image = nil;
    cell.mainLabel.text = nil;
    cell.subLabel.text = nil;

    Row* row = [_gridData.rows objectAtIndex:indexPath.row];
    NSArray* fieldNames = [tableView fieldNames];
    if (fieldNames != nil) {
        LogDebug(@"Populating cell with fieldNames: %@", fieldNames);
        for (NSString* fieldName in fieldNames) {
            AbstractGridDataCell* abstractCell = [row cellForFieldId:fieldName];
            [self populateCel:cell withDataFrom:abstractCell];
        }
    }
    else {
        NSArray* abstractCells = [row cells];
        for (AbstractGridDataCell* abstractCell in abstractCells) {
            [self populateCel:cell withDataFrom:abstractCell];
        }
    }

    if (indexPath.row % 2) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1];
    }
    return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    Row* row = [_gridData.rows objectAtIndex:indexPath.row];

    ActivityMenuItem* edit =
        [[ActivityMenuItem alloc] initWithActivityId:self.activityName title:@"Edit" style:[ActivityStyle defaultStyle]];
    if ([self.activityManager showActivity:edit initialKey:row.rowId]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 75;
}

/* ================================================ Interface Methods =============================================== */
- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change
                        context:(void*)context {

    ThumbnailTableCell* tableCell = (__bridge ThumbnailTableCell*) context;
    ImageGridDataCell* gridDataCell = (ImageGridDataCell*) object;

    tableCell.thumbnail.image = [UIImage imageWithData:gridDataCell.imageData];
    [gridDataCell removeObserver:self forKeyPath:@"imageData"];
}


/* ================================================== Private Methods =============================================== */
- (void) populateCel:(ThumbnailTableCell*)cell withDataFrom:(AbstractGridDataCell*)gridDataCell {

    if ([gridDataCell isKindOfClass:[ImageGridDataCell class]] && cell.thumbnail.image == nil) {
        ImageGridDataCell* imageCell = (ImageGridDataCell*) gridDataCell;
        if (cell.thumbnail.image == nil) {
            [imageCell addObserver:self forKeyPath:@"imageData" options:0 context:(__bridge void*) cell];
        }
        if (imageCell.hasAskedImageToLoad == NO) {
            [imageCell loadImage];
            [_observedCells addObject:imageCell];
        }
    }
    else if ([gridDataCell isKindOfClass:[TextGridDataCell class]]) {
        TextGridDataCell* textCell = (TextGridDataCell*) gridDataCell;
        if (cell.mainLabel.text == nil) {
            cell.mainLabel.text = textCell.text;
        }
        else if (cell.subLabel.text == nil) {
            cell.subLabel.text = textCell.text;
        }
    }
}



@end