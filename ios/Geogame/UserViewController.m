//
//  UserViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "AppDelegate.h"

#import "UserViewController.h"
#import "UserEditProfileTableViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"

#import "Log.h"

@implementation UserViewController

@synthesize navigationBar = _navigationBar;
@synthesize imageView = _imageView;
@synthesize usernameLabel = _usernameLabel;
@synthesize emailLabel = _emailLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the view.
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"backgroundNavigationBar.png"]
     forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];

    // Create the log in view controller
    _logInViewController = [[LoginViewController alloc] init];
    [_logInViewController setDelegate:self];
    
    // Create the sign up view controller
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    [signUpViewController setDelegate:self];
    
    // Assign our sign up controller to be displayed from the login controller
    [_logInViewController setSignUpController:signUpViewController];
    
    AppDelegate* appDelegate;
    _user = [appDelegate user];
    

    // Load user.
    if ([User currentUser])
        [self refreshInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshInterface];
}

- (void)refreshInterface
{
    [super loadView];
    
    User* user = (User*)[User currentUser];
    [_usernameLabel setText:[user username]];
    [_emailLabel setText:[user email]];
    
    // Load user picture.
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"image-example.png"];
    imageView.file = (PFFile *)[user objectForKey:@"picture"];
    [imageView loadInBackground:^(UIImage *image, NSError *error) {
        [_imageView setImage:imageView.image];
        [_imageView reloadInputViews];
    }];
    
    // Load activity.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![User currentUser])
    {        
        // Present the log in view controller
        [self presentViewController:_logInViewController animated:YES completion:NULL];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_activities count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Activity";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark - Memory.

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions.

- (IBAction)logOutAction:(id)sender
{
    // Logout.
    [User logOut];
    
    // Present the log in view controller
    [self presentViewController:_logInViewController animated:YES completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to edit informations of the user.
    if ([[segue identifier] isEqualToString:@"EditUserProfile"])
    {
        UserEditProfileTableViewController *detailViewController = [segue destinationViewController];
        [detailViewController setUser:_user];
        
    }
}

#pragma mark - Delegate.

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    // Load user informations.
    //[_user retrieveFromCloud];
    
    AppDelegate* delegate;
    [delegate setUser:(User*)user];
    
    [self refreshInterface];
    
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
