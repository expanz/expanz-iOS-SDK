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
#import "expanz_model_UserRole.h"

SPEC_BEGIN(UserRoleSpec)

describe(@"Object creation", ^{
    it(@"should allow initialization with role id and description attributes", ^{
        UserRole* role = [[UserRole alloc] initWithRoleId:@"234" andDescription:@"Sales Manager"]; 
        assertThat(role.roleId, equalTo(@"234"));
        assertThat(role.roleDescription, equalTo(@"Sales Manager"));
        assertThat([role description], equalTo(@"UserRole: roleId=234, description=Sales Manager"));
    });
});

SPEC_END