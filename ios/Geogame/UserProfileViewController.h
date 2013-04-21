//
//  UserProfileViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "User.h"


@interface UserProfileViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    AppDelegate* _appDelegate;
    User* _user;
}

@property(nonatomic, retain) AppDelegate* appDelegate;
@property(nonatomic, retain) User* user;
@property(nonatomic, strong) IBOutlet UILabel *welcomeLabel;

- (IBAction)logOutButtonTapAction:(id)sender;

@end
