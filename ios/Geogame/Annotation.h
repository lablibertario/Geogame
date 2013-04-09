//
//  Annotation.h
//  Geogame
//
//  Created by Mathieu Dabek on 18/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "Waypoint.h"

@interface Annotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
    NSString* _title;
    NSString* _subtitle;
    Waypoint *_waypoint;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* subtitle;
@property(nonatomic, retain) Waypoint* waypoint;

- (id)init;

- (id)initWithPFObject:(PFObject*)object;

- (id)initWithWaypoint:(Waypoint*)waypoint;

- (NSString*)toString;

@end
