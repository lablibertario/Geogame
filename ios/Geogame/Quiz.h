//
//  Quiz.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Quiz : PFObject <PFSubclassing>
{
    NSString* _id;
    NSString* _name;
    NSMutableDictionary* _questions;
    bool _isEnabled;
    NSDate* _createdAt;
    NSDate* _updatedAt;
}

@property NSString* id;
@property NSString* name;
@property NSMutableDictionary* questions;
@property bool isEnabled;

- (id)initWithPFObject:(PFObject*)object;

+ (NSString *)parseClassName;

@end
