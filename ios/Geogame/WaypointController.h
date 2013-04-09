//
//  WaypointController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaypointController : NSObject
{
    NSMutableArray *_waypoints;
}

@property (nonatomic, retain) NSMutableArray *waypoints;

- (id)init;

- (void)loadNearestWaypointsInBackground;

@end
