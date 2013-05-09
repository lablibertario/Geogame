//
//  UserPicture.m
//  Geogame
//
//  Created by Mathieu Dabek on 22/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "UserPicture.h"

@implementation UserPicture

@synthesize id = _id;
@synthesize image = _image;
@synthesize isSafe = _isSafe;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

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

+ (NSString *)parseClassName
{
    return @"UserPicture";
}

@end
