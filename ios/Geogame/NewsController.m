//
//  NewsController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>
#import "News.h"
#import "NewsController.h"

@implementation NewsController

@synthesize news = _news;

- (id)init
{
    if(self = [super init])
    {
        _news = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)loadLatestNewsInBackground
{
    PFQuery *query = [PFQuery queryWithClassName:@"News"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // The find succeeded.
             NSLog(@"Successfully retrieved %d news.", objects.count);
             
             // Parse all objects.
             _news = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
                 [_news addObject:[[News alloc] initWithPFObject:[objects objectAtIndex:i]]];
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
}

@end
