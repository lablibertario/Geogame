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
    // See PFUser to get more details about pasword attribute.
    // and other functionalities.
    
    NSString* _firstname;
    NSString* _lastname;
    NSDate* _birthday;
    
    // User's posted comments.
    NSMutableArray* _comments;
    
    // User's published pictures.
    NSMutableArray* _pictures;
}

@property(nonatomic, retain) NSString* firstname;
@property(nonatomic, retain) NSString* lastname;
@property(nonatomic, retain) NSDate* birthday;
@property(nonatomic, retain) NSMutableArray* comments;
@property(nonatomic, retain) NSMutableArray* pictures;

- (id)init;

- (void)retrieveFromCloud;

- (void)loadCommentsInBackground;

@end
