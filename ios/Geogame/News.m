//
//  News.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize id = _id;
@synthesize title = _title;
@synthesize text = _text;
@synthesize isEnabled = _isEnabled;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithId:(NSString *)id title:(NSString *)title text:(NSString *)text isEnabled:(Boolean)isEnabled createdAt:(NSDate *)createdAt updatedAt:(NSDate *)updatedAt
{
    if(self = [super init])
    {
        _id = id;
        _title = title;
        _text = text;
        _isEnabled = isEnabled;
        _createdAt = createdAt;
        _updatedAt = updatedAt;
    }
    
    return self;
}

- (id)initWithPFObject:(PFObject *)object
{
    if(self = [super init])
    {
        _id = [object objectForKey:@"id"];
        _title = [object objectForKey:@"title"];
        _text = [object objectForKey:@"content"];
        _isEnabled = [[object objectForKey:@"isEnabled"] boolValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
        
    }
    
    return self;
}

@end
