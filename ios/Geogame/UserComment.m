//
//  UserComment.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "UserComment.h"

@implementation UserComment

@synthesize id = _id;
@synthesize text = _text;
@synthesize isSafe = _isSafe;
@synthesize createdAt = _createdAt;
@synthesize updatedAt =  _updatedAt;

- (id)initWithId:(NSString*)id text:(NSString*)text isSafe:(Boolean)isSafe createdAt:(NSDate*)createdAt updatedAt:(NSDate*)updatedAt
{
    if(self = [super init])
    {
        _id = id;
        _text = text;
        _isSafe = isSafe;
        _createdAt = createdAt;
        _updatedAt = updatedAt;
    }
    
    return self;
}

- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        _id = [object objectForKey:@"id"];
        _text = [object objectForKey:@"text"];
        _isSafe = [[object objectForKey:@"isSafe"] intValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
    }
    return self;
}

@end
