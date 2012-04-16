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


#import "expanz_ui_components_ThumbnailTableCell.h"


SPEC_BEGIN(ThumbnailTableCellSpec)

    __block ThumbnailTableCell* tableCell;

    describe(@"Properties", ^{
        
        beforeEach(^{        
            tableCell = [[ThumbnailTableCell alloc] init];        
        });

        it(@"should add a mutable mainLabel property to the UITableViewCell", ^{            
            UILabel* label = [[UILabel alloc] init];             
            tableCell.mainLabel = label;
            [[tableCell.mainLabel should] equal:label];
        });
        
        it(@"should add a mutable subLabel property to the UITableViewCell", ^{    
            UILabel* label = [[UILabel alloc] init];
            tableCell.subLabel = label;
            [[tableCell.subLabel should] equal:label];
        });
        
        it(@"should add a fixed sized thumbnail property to the UITableViewCell", ^{
            UIImageView* imageView = [[UIImageView alloc] init];
            tableCell.thumbnail = imageView;
            [[tableCell.thumbnail should] equal:imageView];
        });
    });


SPEC_END