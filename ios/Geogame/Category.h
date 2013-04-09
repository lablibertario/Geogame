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

@interface Category : NSObject
{
    NSString* _id;
    NSString* _name;
    Category* _parent;
    NSMutableArray* _children;
    NSMutableArray* _waypoints;
    Boolean _isEnabled;
    NSDate* _createdAt;
    NSDate* _updatedAt;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) Category* parent;
@property(nonatomic, retain) NSMutableArray* children;
@property(nonatomic, retain) NSMutableArray* waypoints;
@property(nonatomic) Boolean isEnabled;
@property(nonatomic, retain) NSDate* createdAt;
@property(nonatomic, retain) NSDate* updatedAt;

/**
 * Initializes a Category with all parameters.
 */
- (id)initWithId:(NSString*)id name:(NSString*)name parent:(Category*)parent children:(NSMutableArray*)children waypoints:(NSMutableArray*)waypoints isEnabled:(Boolean)isEnabled createdAt:(NSDate*)createdAt updatedAt:(NSDate*)updatedAt;

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

@end
