//
//  Quiz.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>

#import "Quiz.h"

@implementation Quiz

@synthesize id = _id;
@synthesize name = _name;
@synthesize questions = _questions;
@synthesize isEnabled = _isEnabled;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        _id = [object objectForKey:@"id"];
        
        // questions.
        
        _isEnabled = [[object objectForKey:@"isEnabled"] boolValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
    }
    return self;
}

+ (NSString *)parseClassName
{
    return @"Quiz";
}

@end
