//
//  Waypoint.m
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

//#import <Parse/PFObject+Subclass.h>
#import "Waypoint.h"

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


- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        [self setObjectId:[object objectForKey:@"objectId"]];

        NSLog(@"Object for key : %@", [object objectForKey:@"objectId"]);
        NSLog(@"Object ID : %@", self.objectId);
        _id = [object objectForKey:@"id"];
        _name = [object objectForKey:@"name"];
        _category = [object objectForKey:@"category"];
        _picture = [object objectForKey:@"picture"];
        
        // Download picture.
        PFFile *picture = [object objectForKey:@"picture"];
        _picture = [picture getData];
        
        
        _description = [object objectForKey:@"description"];
        _points = [[object objectForKey:@"score"] intValue];
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

+ (NSString *)parseClassName {
    return @"Waypoint";
}

@end
