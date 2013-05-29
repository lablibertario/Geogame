//
//  UserComment.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>

#import "UserComment.h"

@implementation UserComment

@synthesize id = _id;
@synthesize title = _title;
@synthesize body = _body;
@synthesize isSafe = _isSafe;
@synthesize user = _user;
@synthesize waypoint = _waypoint;

- (id)initWithPFObject:(PFObject*)object
{
    if ( self = [super init])
    {
        self.objectId = [object objectId];
        _id = [object objectForKey:@"id"];
        _title = [object objectForKey:@"title"];
        _body = [object objectForKey:@"body"];
        _isSafe = [[object objectForKey:@"isSafe"] intValue];
        createdAt = [object createdAt];
    }
    return self;
}

- (void)saveAsPFObjectInBackground
{
    PFObject *object = [PFObject objectWithClassName:@"UserComment"];
    
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        [object setObject:_title forKey:@"title"];
        [object setObject:_body forKey:@"body"];
        [object setObject:_user forKey:@"user"];
        [object setObject:_waypoint forKey:@"waypoint"];
        [object setObject:_body forKey:@"body"];
        [object setObject:NO forKey:@"isSafe"];
        
        [object saveInBackground];
        
        NSLog(@"Save object %@ in the cloud.", object);
    }];
}

+ (NSString *)parseClassName
{
    return @"UserComment";
}

@end
