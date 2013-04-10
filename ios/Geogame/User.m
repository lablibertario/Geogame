//
//  User.m
//  Geogame
//
//  Created by Mathieu Dabek on 09/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "User.h"
#import "UserComment.h"

@implementation User

@synthesize id = _id;
@synthesize username = _username;
@synthesize email = _email;
@synthesize comments = _comments;
@synthesize pictures = _pictures;

- (id)init
{
    if(self = [super init])
    {
        _comments = [NSMutableArray alloc];
        _pictures = [NSMutableArray alloc];
    }
    
    return self;
}

- (id)initWithPFUser:(PFUser*)user
{
    if(user == nil)
        NSLog(@"Invalid user ! ");
    
    if(self = [super init])
    {
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"username" equalTo: user.username];
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
        
        // Execution of the query in a new thread.
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
             if (!error)
             {
                 PFObject* object = [query getFirstObject];
                 NSLog(@"Object : %@", object);
                 
                 _id = [object objectForKey:@"id"];
                 _username = [object objectForKey:@"username"];
                 _email = [object objectForKey:@"email"];
             }
             else
             {
                 // Log details of the failure
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
             }
         }];
        
        _comments = [NSMutableArray alloc];
        _pictures = [NSMutableArray alloc];
    }
    
    return self;
}

- (NSMutableArray*)comments
{
    // Load comments if unavailables.
    [self loadCommentsInBackground];
    return _comments;
}

- (void)loadCommentsInBackground
{
    // Initialization of the query.
    PFQuery *query = [PFQuery queryWithClassName:@"UserComment"];
    [query whereKey:@"user" equalTo: self];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    // Execution of the query in a new thread.
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // The find succeeded.
             NSLog(@"Successfully retrieved %d comments.", objects.count);
             
             // Parse all objects.
             _comments = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
                 [_comments addObject:[[UserComment alloc] initWithPFObject:[objects objectAtIndex:i]]];
         }
         else
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
}



@end
