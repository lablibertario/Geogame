//
//  User.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize id = _id;
@synthesize username = _username;
@synthesize email = _email;
@synthesize emailVerified = _emailVerified;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        _id = [object objectForKey:@"id"];
        _username = [object objectForKey:@"username"];
        _email = [object objectForKey:@"email"];
        _emailVerified = [[object objectForKey:@"emailVerified"] boolValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
    }
    return self;
}

@end
