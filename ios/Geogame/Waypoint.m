//
//  Waypoint.m
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "Waypoint.h"
#import <Parse/Parse.h>

@implementation Waypoint

@synthesize id = _id;
@synthesize name = _name;
@synthesize category = _category;
@synthesize picture = _picture;
@synthesize description = _description;
@synthesize points = _points;
@synthesize coordinate = _coordinate;
@synthesize isEnabled = _isEnabled;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithId:(NSString*)id name:(NSString*)name category:(Category*)category picture:(NSString*)picture description:(NSString*)description points:(int)points location:(CLLocationCoordinate2D)coordinate isEnabled:(Boolean)isEnabled createdAt:(NSDate*)createdAt updatedAt:(NSDate*)updatedAt
{
    if(self = [super init])
    {
        _id = id;
        _name = name;
        _category = category;
        _picture = picture;
        _description = description;
        _points = points;
        _coordinate = coordinate;
        _isEnabled = isEnabled;
        _createdAt = createdAt;
        _updatedAt = updatedAt;
    }
    return self;
}

- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        _id = [object objectForKey:@"id"];
        _name = [object objectForKey:@"name"];
        _category = [object objectForKey:@"category"];
        _picture = [object objectForKey:@"picture"];
        _description = [object objectForKey:@"description"];
        _points = [[object objectForKey:@"points"] intValue];
        CLLocationCoordinate2D coord;
        PFGeoPoint *p = [object objectForKey:@"location" ];
        coord.latitude = p.latitude;
        coord.longitude = p.longitude;
        _coordinate = coord;
        _isEnabled = [[object objectForKey:@"isEnabled"] boolValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
    }
    return self;
}

- (NSString*)toString
{
    return [[NSString alloc] initWithFormat:@"%@ %@ [%d pts]",_name, _category, _points];
}

@end
