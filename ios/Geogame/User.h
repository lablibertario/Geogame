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
    NSData* _picture;
    
    CLLocationCoordinate2D _location;
    
    // User's posted comments.
    NSMutableArray* _comments;
    
    // User's published pictures.
    NSMutableArray* _pictures;
}

@property(nonatomic, retain) NSString* firstname;
@property(nonatomic, retain) NSString* lastname;
@property(nonatomic, retain) NSDate* birthday;
@property(nonatomic, retain) NSData* picture;
@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain) NSMutableArray* comments;
@property(nonatomic, retain) NSMutableArray* pictures;

- (id)init;

//+ (User*)currentUser;

- (void)retrieveFromCloud;

- (void)loadCommentsInBackground;

+ (User *)currentUser;

@end
