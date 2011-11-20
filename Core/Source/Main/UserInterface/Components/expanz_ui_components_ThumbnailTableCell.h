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


#import <Foundation/Foundation.h>


@interface expanz_ui_components_ThumbnailTableCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UIImageView* thumbnail;
@property(nonatomic, retain) IBOutlet UILabel* mainLabel;
@property(nonatomic, retain) IBOutlet UILabel* subLabel;

@end

/* ================================================================================================================== */
@compatibility_alias ThumbnailTableCell expanz_ui_components_ThumbnailTableCell;