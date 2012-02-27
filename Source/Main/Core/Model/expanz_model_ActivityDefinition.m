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

#import "expanz_model_ActivityDefinition.h"

@implementation expanz_model_ActivityDefinition

@synthesize activityId = _activityId;
@synthesize title = _title;
@synthesize style = _style;


/* ================================================== Initializers ================================================== */
- (id) initWithActivityId:(NSString*)name title:(NSString*)title style:(ActivityStyle*)style {
    self = [self init];
    if (self) {
        _activityId = [name copy];
        _title = [title copy];
        _style = style;
    }
    return self;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Activity id=%@, title=%@", _activityId, _title];
}

@end
