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
@synthesize message = _message;
@synthesize isSafe = _isSafe;
@synthesize createdAt = _createdAt;
@synthesize updatedAt =  _updatedAt;

- (id)initWithId:(NSString*)id message:(NSString*)message isSafe:(Boolean)isSafe createdAt:(NSDate*)createdAt updatedAt:(NSDate*)updatedAt
{
    if(self = [super init])
    {
        _id = id;
        _message = message;
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
        _message = [object objectForKey:@"message"];
        _isSafe = [[object objectForKey:@"isSafe"] intValue];
        _createdAt = [object objectForKey:@"createdAt"];
        _updatedAt = [object objectForKey:@"updatedAt"];
    }
    return self;
}

- (void)saveAsPFObjectInBackground
{
    PFObject *object = [PFObject objectWithClassName:@"UserComment"];
    
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        [object setObject:_message forKey:@"message"];
        [object setObject:NO forKey:@"isSafe"];
        
        [object saveInBackground];
        
        NSLog(@"Save object %@ in the cloud.", object);
    }];
}

@end
