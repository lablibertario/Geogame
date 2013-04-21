//
//  POITableViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 20/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>

#import "AppDelegate.h"
#import "POITableViewController.h"
#import "POITableViewCell.h"
#import "POICommentTableViewController.h"
#import "UserViewController.h"

#import "LoginViewController.h"
#import "SignUpViewController.h"

#import "Waypoint.h"
#import "Log.h"

@implementation POITableViewController

@synthesize user = _user;
@synthesize waypoints = _waypoints;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the view.
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"backgroundNavigationBar.png"]
     forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];
    
    // Set up refresh control.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadNearestPOI) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    if (![[_appDelegate user] isAuthenticated])
    {
        LoginViewController *logInController = [[LoginViewController alloc] init];
        logInController.delegate = self;
        [self presentViewController:logInController animated:YES completion:nil];
        
        return;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_waypoints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a cell identifier.
    static NSString *CellIdentifier = @"POITableCell";
    POITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[POITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Retrieve waypoint.
    Waypoint* waypoint = [_waypoints objectAtIndex:indexPath.row];
    
    // Set up interface.
    [[cell waypointNameLabel] setText:[waypoint name]];
    if([waypoint picture])
        [[cell waypointImageView] setImage:[UIImage imageWithData:[waypoint picture]]];
    
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

- (void)loadNearestPOI
{    
    // User's location
    PFGeoPoint *userGeoPoint = [[User currentUser] objectForKey:@"location"];
    
    if(userGeoPoint == nil)
    {
        userGeoPoint.latitude = 43.5;
        userGeoPoint.longitude = 4.5;
    }
    
    // Query for POI retrieving.
    PFQuery *query = [PFQuery queryWithClassName:@"Waypoint"];
    [query whereKey:@"location" nearGeoPoint:userGeoPoint];
    [query setLimit:20];
    [query orderByAscending:@"location"];
    
    // Find objets in background.
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // Parse all objects.
             _waypoints = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
                 [_waypoints addObject:[[Waypoint alloc] initWithPFObject:[objects objectAtIndex:i]]];
             
             // Reload table view.
             [self.tableView reloadData];
         }
         else
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];

    // Stop table refresh activity indicator.
    [self.refreshControl endRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to show more informations about a waypoint.
    if ([[segue identifier] isEqualToString:@"ShowPOIDetail"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        POICommentTableViewController *detailViewController = [segue destinationViewController];
        [detailViewController setWaypoint:[_waypoints objectAtIndex:selectedRowIndex.row]];
    }
    
    // Segue to show waypoint's comments.
    if ([[segue identifier] isEqualToString:@"ShowPOIComments"])
    {
        // Get index of the object in the table view.
        UIButton *button = (UIButton *)sender;
        CGRect buttonFrame = [button convertRect:button.bounds toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonFrame.origin];
        
        // Create a destination controller and add selected waypoint.
        POICommentTableViewController *commentTableViewController = [segue destinationViewController];
        [commentTableViewController setWaypoint:[_waypoints objectAtIndex:indexPath.row]];
    }
}

#pragma mark - User auth delegate.

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    // Load user informations.
    [_user retrieveFromCloud];
    
    // Load nearest waypoints.
    [self loadNearestPOI];
    
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
