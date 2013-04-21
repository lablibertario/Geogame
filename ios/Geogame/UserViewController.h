//
//  UserViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "User.h"

@interface UserViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    UINavigationBar* _navigationBar;
    UIImageView* _imageView;
    UILabel* _usernameLabel;
    UILabel* _emailLabel;
    UITableView* _activityTableView;
    
    UIButton* _logOutButton;
    
    User* _user;
}

@property(nonatomic, retain) IBOutlet UINavigationBar* navigationBar;
@property(nonatomic, retain) IBOutlet UIImageView* imageView;
@property(nonatomic, retain) IBOutlet UILabel* usernameLabel;
@property(nonatomic, retain) IBOutlet UILabel* emailLabel;
@property(nonatomic, retain) IBOutlet UITableView* activityTableView;

@property(nonatomic, retain) IBOutlet UIButton* logOutButton;

@property(nonatomic, retain) User* user;

- (IBAction)logOutAction:(id)sender;

@end
