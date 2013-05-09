//
//  UserEditProfileTableViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

@interface UserEditProfileTableViewController : UITableViewController
{
    User* _user;
}

@property(nonatomic, retain) User* user;

@end
