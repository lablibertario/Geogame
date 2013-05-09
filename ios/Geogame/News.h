//
//  News.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface News : PFObject <PFSubclassing>
{
    NSString* _id;
    NSString* _title;
    NSString* _text;
    Boolean _isEnabled;
    NSDate* _createdAt;
    NSDate* _updatedAt;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* text;
@property(nonatomic) Boolean isEnabled;
@property(nonatomic, retain) NSDate* createdAt;
@property(nonatomic, retain) NSDate* updatedAt;

- (id)initWithPFObject:(PFObject*)object;

+ (NSString *)parseClassName;

@end
