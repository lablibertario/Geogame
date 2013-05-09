//
//  UserComment.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"
#import "Waypoint.h"

@interface UserComment : PFObject <PFSubclassing>
{
    NSString* _id;
    User* _user;
    Waypoint* _waypoint;
    NSString* _title;
    NSString* _body;
    Boolean _isSafe;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain)  User* user;
@property(nonatomic, retain)  Waypoint* waypoint;
@property(nonatomic, retain)  NSString* title;
@property(nonatomic, retain)  NSString* body;
@property(nonatomic)  Boolean isSafe;

/**
 * Initializes a UserComment with a PFObject.
 * @see Parse Framework to get more details.
 */
- (id)initWithPFObject:(PFObject*)object;

- (void)saveAsPFObjectInBackground;

+ (NSString *)parseClassName;

@end
