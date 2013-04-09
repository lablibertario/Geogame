//
//  WaypointManager.m
//  Geogame
//
//  Created by Mathieu Dabek on 11/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "WaypointManager.h"

@class Waypoint;

@implementation WaypointManager

@synthesize waypoints = _waypoints;

- (id)init
{
    if(self = [super init])
    {
        _waypoints = [NSMutableArray alloc];
    }
    
    return self;
}

- (void)loadNearestWaypointsFrom:(id)location withLimit:(int)limit
{

    // Clear current objects.
    [_waypoints removeAllObjects];
}

@end
