//
//  UserViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "Log.h"

@implementation UserViewController

@synthesize navigationBar = _navigationBar;
@synthesize imageView = _imageView;
@synthesize usernameLabel = _usernameLabel;
@synthesize emailLabel = _emailLabel;

@synthesize user = _user;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"backgroundNavigationBar.png"];
    [_navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];
    
    
    
    [_usernameLabel setText:[_user username]];
    [_emailLabel setText:[_user email]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    AppDelegate* delegate;
    
    if (![User currentUser])
    {
        
        LoginViewController *logInController = [[LoginViewController alloc] init];
        logInController.delegate = self;
        
        [self presentViewController:logInController animated:NO completion:nil];
        
        return;
    }
    
    [[delegate user] retrieveFromCloud];
}

#pragma mark - Memory.

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions.

- (IBAction)logOutAction:(id)sender
{
    NSLog(@"UserViewController.logOutAction.");
    
    if(sender == _logOutButton)
    {
        // Logout user.
        [PFUser logOut];
        
        // Present new login view.
        LoginViewController* loginViewController = [[LoginViewController alloc] init];
        [loginViewController setDelegate:self];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

#pragma mark - Delegate.

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    // Load user informations.
    [_user retrieveFromCloud];
    
    // Dismiss login view.
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    // Save a log in the cloud.
    Log* log = [[Log alloc] init];
    [log setTitle:@"Authentication error."];
    [log setMessage:@"Connection attempt with bad credentials."];
    [log saveEventually];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    // Present new signup view.
    SignUpViewController* signupViewController = [[SignUpViewController alloc] init];
    [signupViewController setDelegate:self];
    [self presentViewController:signupViewController animated:YES completion:nil];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    // Present new login view.
    LoginViewController *logInController = [[LoginViewController alloc] init];
    logInController.delegate = self;
    [self presentViewController:logInController animated:YES completion:nil];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    // Save a log in the cloud.
    Log* log = [[Log alloc] init];
    [log setTitle:@"Registration error."];
    [log setMessage:@"An error occured during signup process."];
    [log saveEventually];
}



@end
