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

#import "SpecHelper.h"
#import "UITableView+DataPublication.h"
#import "OCMockObject.h"

SPEC_BEGIN(UITableView_DataPublicationSpec)

    __block UITableView* tableView; 
    beforeEach(^{
        tableView = [[UITableView alloc] init];
    });

    it(@"should add a dataPublicationId property to UITableView", ^{
        [tableView setDataPublicationId:@"customersList"];
    });
    
    it(@"should add a populateMethod property to UITableView", ^{
        [tableView setPopulateMethod:@"customersListMethod"];
    });

    it(@"should add a query property to UITableView", ^{
        [tableView setQuery:@"customersListQuery"];
    });

    it(@"should add an autoPopulate method to UITableView", ^{
        [tableView setAutoPopulate:NO];
    });
    
    afterEach(^{
        [tableView release];
    });
    

SPEC_END
