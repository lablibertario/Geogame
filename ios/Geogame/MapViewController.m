//
//  MapViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "MapViewController.h"
#import "WaypointViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "Annotation.h"

@interface MapViewController ()

@property (nonatomic, strong) IBOutlet WaypointViewController *detailViewController;

@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;

@synthesize annotations = _annotations;
@synthesize navigationBar = _navigationBar;
@synthesize tabBar = _tabBar;


#pragma mark - Life cylcle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load waypoints.
    [self loadNearestWaypointsInBackground];
    
    // Set up the view.
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"backgroundNavigationBar.png"]
     forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];
    
    // Default map'region.
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 43.23138390229439;
    newRegion.center.longitude = 5.437835454940796;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    _mapView.delegate = self;
    [self.mapView setRegion:newRegion animated:YES];
    
    // Init location manager.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLLocationAccuracyKilometer;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [_locationManager startUpdatingLocation];
    
    // Set up login view.
    if (![User currentUser])
    {
        // Create the log in view controller
        _loginViewController = [[LoginViewController alloc] init];
        [_loginViewController setDelegate:self];
            
        // Create the sign up view controller
        SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
            
        // Assign our sign up controller to be displayed from the login controller
        [_loginViewController setSignUpController:signUpViewController];
    }
    else
    {
        [self refreshInterface];
    }
}

- (void)refreshInterface
{
    // Load annotations.
    _annotations = [[NSMutableArray alloc] initWithCapacity:[_waypoints count]];
    for(int i=0; i<[_waypoints count]; i++)
        [_annotations addObject:[[Annotation alloc] initWithWaypoint:[_waypoints objectAtIndex:i]]];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:_annotations];
    //NSLog(@"Nb annotations (from WC) : %d", [_annotations count]);
}

- (void)viewWillAppear:(BOOL)animated
{

    
    // Focus on user location.
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance([_locationManager location].coordinate, 5000.0, 5000.0);
    [_mapView setRegion:userLocation animated:true];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![User currentUser])
    {
        // Present the log in view controller
        [self presentViewController:_loginViewController animated:YES completion:NULL];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)viewDidUnload
{
    _locationManager.delegate = nil;
    _locationManager = nil;
    _mapView = nil;
    _annotations = nil;
}

#pragma mark - Actions

- (IBAction)changeMapType:(id)sender
{
    if([_mapView mapType] == MKMapTypeStandard)
        [_mapView setMapType:MKMapTypeHybrid];
    else
        [_mapView setMapType:MKMapTypeStandard];
}

- (IBAction)refreshMap:(id)sender
{
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance([_locationManager location].coordinate, 5000.0, 5000.0);
    [_mapView setRegion:userLocation animated:true];
}

- (IBAction)showNavigationBar:(id)sender
{
    //NSLog(@"ShowNavigationBar");
    if([_navigationBar isHidden])
    {
        [_navigationBar setHidden:false];
        
    }
    else
    {
        [_navigationBar setHidden:true];
    }
}


- (IBAction)swipeMap:(id)sender
{
    [_locationManager stopUpdatingLocation];
}

#pragma mark - Map View

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion userRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1500.0, 1500.0);
    [_mapView setRegion:userRegion animated:true];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	// Work around a bug in MapKit where user location is not initially zoomed to.
	if (oldLocation == nil) {
		// Zoom to the current user location.
		MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 5000, 5000);
		[_mapView setRegion:userLocation animated:YES];
	}
}


#pragma mark - Annotations

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // User's location annotation.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[Annotation class]])
    {
        // Try to dequeue an existing pin view first.
        static NSString *AnnotationIdentifier = @"Annotation";
        
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)
        [self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        if (pinView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            customPinView.canShowCallout = YES;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            //[rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

- (void)loadNearestWaypointsInBackground
{
    PFQuery *query = [PFQuery queryWithClassName:@"Waypoint"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // The find succeeded.
             //NSLog(@"Successfully retrieved %d waypoints.", objects.count);
             
             // Parse all objects.
             _waypoints = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
                 [_waypoints addObject:[[Waypoint alloc] initWithPFObject:[objects objectAtIndex:i]]];
             
             [self performSelectorOnMainThread:@selector(refreshInterface) withObject:nil waitUntilDone:FALSE];
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
    
    
}

-(void) reloadMap
{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 43.23138390229439;
    newRegion.center.longitude = 5.437835454940796;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    [_mapView setRegion:newRegion animated:TRUE];
    
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"showWaypointDetails" sender:view];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *) segue sender:(id) sender
{
    if ([segue.identifier isEqualToString:@"showWaypointDetails"]) {
        WaypointViewController *waypointViewController = segue.destinationViewController;
        
        [waypointViewController setWaypoint:[[sender annotation] waypoint]];
    }
}

#pragma mark - User auth delegate.

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    
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


#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
