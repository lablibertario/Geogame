//
//  UserCheckIn.h
//  Geogame
//
//  Created by Mathieu Dabek on 12/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>

@interface UserCheckIn : PFObject  <PFSubclassing>
{
    NSString* _title;
}

@property(nonatomic, retain) NSString* title;

- (id)initWithPFObject:(PFObject*)object;

+ (NSString *)parseClassName;

@end
