//
//  Category.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class Waypoint;

@interface Category : PFObject <PFSubclassing>
{
    NSString* _id;
    NSString* _name;
    Category* _parent;
    NSMutableArray* _children;
    NSMutableArray* _waypoints;
    Boolean _isEnabled;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) Category* parent;
@property(nonatomic, retain) NSMutableArray* children;
@property(nonatomic, retain) NSMutableArray* waypoints;
@property(nonatomic) Boolean isEnabled;

/**
 * Initializes a Category with a PFObject.
 * @see Parse Framework to get more details.
 */
- (id)initWithPFObject:(PFObject*)object;

/**
 * Add a new item to the list of waypoints.
 */
- (void)addWaypoint:(Waypoint*)waypoint;

/**
 * Add a new item to the list of categories.
 */
- (void)addCategory:(Category*)category;

- (NSString*)toString;

+ (NSString *)parseClassName;

@end
