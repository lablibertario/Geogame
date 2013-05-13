//
//  UserViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "LoginViewController.h"

#import "User.h"

@interface UserViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UINavigationBar* _navigationBar;
    UIImageView* _imageView;
    UILabel* _usernameLabel;
    UILabel* _emailLabel;
    UITableView* _activityTableView;
    
    UILabel* _locationLabel;
    UILabel* _checkInsLabel;
    UILabel* _commentsLabel;
    UILabel* _scoreLabel;
    
    UIButton* _logOutButton;
    
    User* _user;
    
    NSMutableArray* _checkIns;
    NSMutableArray* _comments;
    
    LoginViewController* _logInViewController;
}

@property(nonatomic, retain) IBOutlet UINavigationBar* navigationBar;
@property(nonatomic, retain) IBOutlet UIImageView* imageView;
@property(nonatomic, retain) IBOutlet UILabel* usernameLabel;
@property(nonatomic, retain) IBOutlet UILabel* locationLabel;
@property(nonatomic, retain) IBOutlet UILabel* checkInsLabel;
@property(nonatomic, retain) IBOutlet UILabel* commentsLabel;
@property(nonatomic, retain) IBOutlet UILabel* scoreLabel;
@property(nonatomic, retain) IBOutlet UILabel* emailLabel;
@property(nonatomic, retain) IBOutlet UITableView* activityTableView;

@property(nonatomic, retain) IBOutlet UIButton* logOutButton;

@property(nonatomic, retain) User* user;

@property(nonatomic, retain) NSMutableArray* checkIns;
@property(nonatomic, retain) NSMutableArray* comments;

- (IBAction)logOutAction:(id)sender;

@end
