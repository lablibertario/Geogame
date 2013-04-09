//
//  WaypointManager.h
//  Geogame
//
//  Created by Mathieu Dabek on 11/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class Waypoint;

@interface WaypointManager : NSObject
{
    NSMutableArray* _waypoints;
}

@property(nonatomic, retain) NSMutableArray* waypoints;

- (id)init;

- (void)loadNearestWaypointsFrom:(CLLocation*)location withLimit:(int)limit;

@end
