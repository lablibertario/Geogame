//
//  UserPicture.h
//  Geogame
//
//  Created by Mathieu Dabek on 22/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface UserPicture : NSObject
{
    NSString* _id;
    NSData* _image;
    Boolean _isSafe;
    NSDate* _createdAt;
    NSDate* _updatedAt;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain) NSData* image;
@property(nonatomic) Boolean isSafe;
@property(nonatomic, retain) NSDate* createdAt;
@property(nonatomic, retain) NSDate* updatedAt;

- (id)initWithPFObject:(PFObject*)object;

@end
