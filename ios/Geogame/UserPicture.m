//
//  UserPicture.m
//  Geogame
//
//  Created by Mathieu Dabek on 22/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "UserPicture.h"

@implementation UserPicture

@synthesize id = _id;
@synthesize image = _image;
@synthesize isSafe = _isSafe;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithId:(NSString *)id image:(NSData *)image isSafe:(Boolean)isSafe createdAt:(NSDate *)createdAt updatedAt:(NSDate *)updatedAt
{
    if(self = [super init])
    {
        _id = id;
        _image = image;
        _isSafe = isSafe;
        _createdAt= createdAt;
        _updatedAt = updatedAt;
    }
    
    return self;
}

- (id)initWithPFObject:(PFObject *)object
{
    if(self = [super init])
    {
        _id = [object objectForKey:@"id"];
        _image = [object objectForKey:@"image"];
        _isSafe = [[object objectForKey:@"isSafe"] boolValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
    }
    
    return self;
}

@end
