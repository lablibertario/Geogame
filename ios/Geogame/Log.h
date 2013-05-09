//
//  Log.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>

@interface Log : PFObject <PFSubclassing>
{
    NSString* _title;
    NSString* _message;
}

@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* message;

- (id)init;

+ (NSString *)parseClassName;

@end
