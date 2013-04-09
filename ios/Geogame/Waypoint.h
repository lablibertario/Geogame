//
//  Waypoint.h
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class Category;

@interface Waypoint : NSObject
{
    NSString* _id;
    NSString* _name;
    Category* _category;
    NSString* _picture;
    NSString* _description;
    CLLocationCoordinate2D _coordinate;
    int _points;
    Boolean _isEnabled;
    NSDate* _createdAt;
    NSDate* _updatedAt;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) Category* category;
@property(nonatomic, retain) NSString* picture;
@property(nonatomic, retain) NSString* description;
@property(nonatomic) int points;
@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic) Boolean isEnabled;
@property(nonatomic, retain) NSDate* createdAt;
@property(nonatomic, retain) NSDate* updatedAt;

/**
 * Initializes a Waypoint with all parameters.
 */
- (id)initWithId:(NSString*)id name:(NSString*)name category:(Category*)category picture:(NSString*)picture description:(NSString*)description points:(int)points location:(CLLocationCoordinate2D)coordinate isEnabled:(Boolean)isEnabled createdAt:(NSDate*)createdAt updatedAt:(NSDate*)updatedAt;

/**
 * Initializes a Waypoint with a PFObject.
 * @see Parse Framework to get more details.
 */
- (id)initWithPFObject:(PFObject*)object;

- (NSString*)toString;

@end
