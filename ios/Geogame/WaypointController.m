//
//  WaypointController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>
#import "Waypoint.h"
#import "WaypointController.h"

@implementation WaypointController

@synthesize waypoints = _waypoints;

- (id)init
{
    if(self = [super init])
    {
        _waypoints = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)loadNearestWaypointsInBackground
{
    PFQuery *query = [PFQuery queryWithClassName:@"Waypoint"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // The find succeeded.
             NSLog(@"Successfully retrieved %d waypoints.", objects.count);
             
             // Parse all objects.
             _waypoints = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
                 [_waypoints addObject:[[Waypoint alloc] initWithPFObject:[objects objectAtIndex:i]]];             
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
    
}

@end
