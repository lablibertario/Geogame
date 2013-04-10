//
//  User.h
//  Geogame
//
//  Created by Mathieu Dabek on 09/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser
{
    // User's id.
    NSString* _id;
    
    // User's username.
    NSString* _username;
    
    // User's email.
    NSString* _email;
    
    // See PFUser to get more details about pasword attribute.
    // and other functionalities.
    
    // User's posted comments.
    NSMutableArray* _comments;
    
    // User's published pictures.
    NSMutableArray* _pictures;
}

@property(nonatomic, retain) NSString* id;
@property(nonatomic, retain) NSString* username;
@property(nonatomic, retain) NSString* email;
@property(nonatomic, retain) NSMutableArray* comments;
@property(nonatomic, retain) NSMutableArray* pictures;

- (id)init;

- (id)initWithPFUser:(PFUser*)user;

- (void)loadCommentsInBackground;

@end
