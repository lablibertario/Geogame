//
//  Category.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>

#import "Category.h"

@implementation Category

@synthesize id = _id;
@synthesize name = _name;
@synthesize parent = _parent;
@synthesize children = _children;
@synthesize waypoints = _waypoints;
@synthesize isEnabled = _isEnabled;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        _id = [object objectForKey:@"id"];
        _name = [object objectForKey:@"name"];
        _isEnabled = [[object objectForKey:@"isEnabled"] boolValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
    }
    return self;
}

- (void)addWaypoint:(Waypoint*)waypoint
{
    if(waypoint != nil)
        [_waypoints addObject:waypoint];
}

- (void)addCategory:(Category*)category
{
    if(category != nil)
        [_children addObject:category];
}

- (NSString*)toString
{
    return [[NSString alloc] initWithFormat:@"%@ - [%lu sub categories / %lu waypoints]",_name,(unsigned long)[_children count], (unsigned long)[_waypoints count]];
}

+ (NSString *)parseClassName
{
    return @"Category";
}

@end
