//
//  Annotation.m
//  Geogame
//
//  Created by Mathieu Dabek on 18/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

- (id)init
{
    if(self = [super init])
    {
        
        CLLocationCoordinate2D coord;
        coord.latitude = 43.222222;
        coord.longitude = 5.458611;
        _coordinate = coord;
        _title = @"ESIL";
        _subtitle = @"Founders' school.";
        _waypoint = nil;
    }
    
    return self;
}

- (id)initWithPFObject:(id)object
{
    if(self = [self init])
    {
        CLLocationCoordinate2D coord;
        PFGeoPoint *p = [object objectForKey:@"location" ];
        coord.latitude = p.latitude;
        coord.longitude = p.longitude;
        _coordinate = coord;
        _title = [object objectForKey:@"name"];
        _subtitle = [object objectForKey:@"createdAt"];
    }
    
    return self;
}

- (id)initWithWaypoint:(id)waypoint
{
    if(self = [super init])
    {
        CLLocationCoordinate2D coord = [waypoint coordinate];
        _coordinate = coord;
        _title = [waypoint name];
        _waypoint = waypoint;
    }
    
    return self;
}

- (NSString*)toString
{
    
    return _title;
}

@end
