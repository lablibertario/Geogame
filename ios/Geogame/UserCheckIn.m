//
//  UserCheckIn.m
//  Geogame
//
//  Created by Mathieu Dabek on 12/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "UserCheckIn.h"

#import <Parse/PFObject+Subclass.h>

@implementation UserCheckIn

@synthesize title = _title;

- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        _title = [object objectForKey:@"title"];
        createdAt = [object objectForKey:@"createdAt"];
    }
    return self;
}

+ (NSString *)parseClassName
{
    return @"UserCheckIn";
}

@end
