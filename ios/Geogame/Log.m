//
//  Log.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "Log.h"

@implementation Log

@synthesize title = _title;
@synthesize message = _message;

- (id)init
{
    if(self = [super init])
    {
        // ..
    }
    
    return self;
}

- (void)saveEventually
{
    PFObject *log = [PFObject objectWithClassName:@"Log"];
    [log setObject:_title forKey:@"title"];
    [log setObject:_message forKey:@"message"];
    [log saveEventually];
}

@end
