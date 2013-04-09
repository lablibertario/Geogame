//
//  User.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : NSObject
{
    NSString* _id;
    NSString* _username;
    NSString* _email;
    Boolean _emailVerified;
    NSDate* _createdAt;
    NSDate* _updatedAt;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain) NSString* username;
@property(nonatomic, retain) NSString* email;
@property(nonatomic) Boolean emailVerified;
@property(nonatomic, retain) NSDate* createdAt;
@property(nonatomic, retain) NSDate* updatedAt;

/**
 * Initializes a User with a PFObject.
 * @see Parse Framework to get more details.
 */
- (id)initWithPFObject:(PFObject*)object;

@end
