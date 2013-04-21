//
//  User.m
//  Geogame
//
//  Created by Mathieu Dabek on 09/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "UserComment.h"

@implementation User

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

- (void)retrieveFromCloud
{
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query setCachePolicy:kPFCachePolicyNetworkElseCache];
    [query whereKey:@"username" equalTo:self.username];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
    {
        if (!error)
        {
            NSLog(@"Successfully retrieved %@.", object);
            
            _firstname = [object objectForKey:@"firstname"];
            _lastname = [object objectForKey:@"lastname"];
            _birthday = [object objectForKey:@"birthday"];
            
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate setUser:self];
            
            NSLog(@"Retrieve user : %@", object);
        }
        else
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
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
