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
#import "Annotation.h"

@interface MapViewController ()

@property (nonatomic, strong) IBOutlet WaypointViewController *detailViewController;

@end

@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;

@synthesize waypointController = _waypointController;
@synthesize annotations = _annotations;
@synthesize navigationBar = _navigationBar;
@synthesize tabBar = _tabBar;


#pragma mark - Life cylcle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the controller of nearest waypoints.
    AppDelegate *delegate = [[UIApplication  sharedApplication] delegate];
    
    if (![delegate currentUser])
    {
        LoginViewController *logInController = [[LoginViewController alloc] init];
        logInController.delegate = self;
        
        [self presentViewController:logInController animated:YES completion:nil];
    }
    
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
    
    
    
    // Load annotations.
    _annotations = [[NSMutableArray alloc] initWithCapacity:[[_waypointController waypoints] count]];
    for(int i=0; i<[[_waypointController waypoints] count]; i++)
        [_annotations addObject:[[Annotation alloc] initWithWaypoint:[[_waypointController waypoints] objectAtIndex:i]]];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:_annotations];
    NSLog(@"Nb annotations (from WC) : %d", [_annotations count]);
    
}

- (void)viewWillAppear:(BOOL)animated
{

    
    // Focus on user location.
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance([_locationManager location].coordinate, 5000.0, 5000.0);
    [_mapView setRegion:userLocation animated:true];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidUnload
{
    _locationManager.delegate = nil;
    _locationManager = nil;
    _mapView = nil;
    _waypointController = nil;
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
    NSLog(@"ShowNavigationBar");
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

- (void)logInViewController:(PFLogInViewController *)controller didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    AppDelegate *delegate = [[UIApplication  sharedApplication] delegate];
    delegate.user = [[User alloc] initWithPFUser:user];
    
    
    NSLog(@"User : %@ - %@", delegate.user.username, delegate.user.email);
    //NSLog(@"Comments : %d", [delegate.user comments].count);
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    NSLog(@"Need registered user ! ");
    [self dismissModalViewControllerAnimated:NO];
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
