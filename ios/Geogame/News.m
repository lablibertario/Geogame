//
//  News.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>

#import "News.h"

@implementation News

@synthesize id = _id;
@synthesize title = _title;
@synthesize text = _text;
@synthesize isEnabled = _isEnabled;
@synthesize createdAt = _createdAt;
@synthesize updatedAt = _updatedAt;

- (id)initWithPFObject:(PFObject *)object
{
    if(self = [super init])
    {
        _id = [object objectForKey:@"id"];
        _title = [object objectForKey:@"title"];
        _text = [object objectForKey:@"content"];
        _isEnabled = [[object objectForKey:@"isEnabled"] boolValue];
        self.createdAt = [object createdAt];
        self.updatedAt = [object updatedAt];
        
    }
    
    return self;
}

+ (NSString *)parseClassName
{
    return @"News";
}

@end
