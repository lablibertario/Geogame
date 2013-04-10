//
//  UserComment.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface UserComment : NSObject
{
    NSString* _id;
    NSString* _message;
    Boolean _isSafe;
    NSDate* _createdAt;
    NSDate* _updatedAt;
}

@property NSString* id;
@property NSString* message;
@property Boolean isSafe;
@property NSDate* createdAt;
@property NSDate* updatedAt;

- (id)initWithId:(NSString*)id message:(NSString*)message isSafe:(Boolean)isSafe createdAt:(NSDate*)createdAt updatedAt:(NSDate*)updatedAt;

/**
 * Initializes a UserComment with a PFObject.
 * @see Parse Framework to get more details.
 */
- (id)initWithPFObject:(PFObject*)object;

- (void)saveAsPFObjectInBackground;


@end
