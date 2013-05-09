//
//  POIDetailViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "POIDetailViewController.h"
#import "QuizTableViewController.h"
#import "Annotation.h"
#import "User.h"


@implementation POIDetailViewController

@synthesize waypoint = _waypoint;

@synthesize waypointNameLabel = _waypointNameLabel;
@synthesize waypointMapView = _waypointMapView;
@synthesize waypointImageView = _waypointImageView;
@synthesize waypointDescriptionTextView = _waypointDescriptionTextView;

@synthesize checkInButton = _checkInButton;
@synthesize showCommentsButton = _showCommentsButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [_waypointNameLabel setText:[_waypoint name]];
    [_waypointDescriptionTextView setText:[_waypoint description]];
    [_waypointImageView setImage:[UIImage imageWithData:[_waypoint picture]]];
    
    // Center map on the location of the waypoint.
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = [_waypoint coordinate].latitude;
    newRegion.center.longitude = [_waypoint coordinate].longitude;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    [_waypointMapView setDelegate:self];
    [_waypointMapView setRegion:newRegion animated:NO];
    
    // Add an annotation to show the waypoint on the map.
    Annotation *annotation = [[Annotation alloc] initWithWaypoint:_waypoint];
    [_waypointMapView removeAnnotations:_waypointMapView.annotations];
    [_waypointMapView addAnnotation:annotation];
    
    _waypoint = [[Waypoint alloc] init];
    
    CLLocationCoordinate2D coordinates[2];
    coordinates[0] = _waypoint.coordinate;
    coordinates[1] = [_waypointMapView userLocation].coordinate;
    //coordinates[1] = [[User currentUser] coordinate];
    
    MKPolyline* route = [MKPolyline polylineWithCoordinates:coordinates count:2];
    [_waypointMapView addOverlay:route];
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
        [_waypointMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        if (pinView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                                  initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = NO;
            
            
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

- (IBAction)checkInAction:(UIButton *)checkInButton
{
    NSLog(@"Check In !");
    
    PFGeoPoint* userGeoPoint = [[User currentUser] objectForKey:@"location"];
    CLLocationCoordinate2D userCoordinate;
    userCoordinate.latitude = userGeoPoint.latitude;
    userCoordinate.longitude = userGeoPoint.longitude;
    
    // Check distance between user and waypoint.
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:userCoordinate.latitude longitude:userCoordinate.longitude];
    CLLocation *waypointLocation = [[CLLocation alloc] initWithLatitude:[_waypoint coordinate].latitude longitude:[_waypoint coordinate].longitude];
    CLLocationDistance distance = [userLocation distanceFromLocation:waypointLocation];
    /*
    if(distance > 10000.0f)
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"You are so far away! You need to be in 50 meters around the area to check in !" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [message show];
        
        return;
    }*/
    
    NSLog(@"Distance : %f", distance);
    
    // Save checkIn.
    /*
    PFObject* object = [PFObject objectWithClassName:@"UserCheckIn"];
    [object setObject:[User currentUser] forKey:@"user"];
    [object setObject:[_waypoint objectId] forKey:@"waypoint"];
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Yeah !" message:@"You've just posted a new check in!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
            NSLog(@"Saved");
        } else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"We can not save your check in. Please try again!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
        }
    }];
    */
    /*
    PFObject* object = _waypoint;
    [object save];

            PFUser *user = [PFUser currentUser];
            PFRelation *relation = [user relationforKey:@"checkIn"];
            [relation addObject:@"plop"];
            [user save];

    */
    
    /*
        if(!error) {
    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [user relationforKey:@"checkIn"];
    [relation addObject:_waypoint];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Yeah !" message:@"You've just posted a new check in!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
            NSLog(@"Saved");
        } else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"We can not save your check in. Please try again!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
        }
    }]; }*/
    
    
    //[_waypoint setObject:[User currentUser] forKey:@"checkIn"];
    //[_waypoint saveInBackground];
    
    NSLog(@"Yop");
}

- (IBAction)showCommentsAction:(UIButton *)showCommentsButton
{
    NSLog(@"Not supported yet !");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to show more informations about a waypoint.
    if ([[segue identifier] isEqualToString:@"ShowPOIQuiz"])
    {
        QuizTableViewController *detailViewController = [segue destinationViewController];
        [detailViewController setWaypoint:_waypoint];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
