//
//  POIDetailViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "POIDetailViewController.h"
#import "POINewCommentViewController.h"
#import "POICommentTableViewController.h"
#import "QuizTableViewController.h"
#import "Annotation.h"
#import "User.h"
#import "UserCheckIn.h"
#import "MapViewController.h"

@implementation POIDetailViewController

@synthesize waypoint = _waypoint;

@synthesize waypointNameLabel = _waypointNameLabel;
@synthesize waypointReferenceLabel = _waypointReferenceLabel;
@synthesize waypointMapView = _waypointMapView;
@synthesize waypointImageView = _waypointImageView;
@synthesize waypointDescriptionTextView = _waypointDescriptionTextView;

@synthesize checkInButton = _checkInButton;
@synthesize showCommentsButton = _showCommentsButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [_waypointNameLabel setText:[_waypoint name]];
    [_waypointReferenceLabel setText:[_waypoint objectId]];
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
        PFGeoPoint* userGeoPoint = [[User currentUser] objectForKey:@"location"];
        CLLocationCoordinate2D userCoordinate;
        userCoordinate.latitude = userGeoPoint.latitude;
        userCoordinate.longitude = userGeoPoint.longitude;
        
        // Check distance between user and waypoint.
        CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:userCoordinate.latitude longitude:userCoordinate.longitude];
        CLLocation *waypointLocation = [[CLLocation alloc] initWithLatitude:[_waypoint coordinate].latitude longitude:[_waypoint coordinate].longitude];
        CLLocationDistance distance = [userLocation distanceFromLocation:waypointLocation];
        
        NSLog(@"Distance : %f", distance);
        if(distance > 2000.0f)
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"You are so far away! You need to be in 50 meters around the area to check in !" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
        
            return;
        }
        
        // Create a new checkIn.
        UserCheckIn* checkIn = (UserCheckIn*)[PFObject objectWithClassName:@"UserCheckIn"];
        [checkIn setObject:[_waypoint name] forKey:@"title"];
        
        [checkIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error)
            {
                // Save user's relation.
                PFUser *user = [PFUser currentUser];
                PFRelation *userRelation = [user relationforKey:@"checkIns"];
                [userRelation addObject:checkIn];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if(!error)
                    {
                        // Save waypoint's relation.
                        //NSLog(@"ID : %@", [_waypoint objectId]);
                        PFRelation *waypointRelation = [_waypoint relationforKey:@"checkIns"];
                        [waypointRelation addObject:checkIn];
                        [_waypoint saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if(!error)
                            {
                                // Update user's score.
                                 PFUser *user = [PFUser currentUser];
                                int score = [[user objectForKey:@"score"] integerValue];
                                score += [_waypoint points];
                                
                                [user setObject:[NSString stringWithFormat:@"%d", score] forKey:@"score"];
                                [user saveInBackground];
                                
                                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Check in with success" message:@"Your check-in succesfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                [message show];
                            }
                            else
                            {
                                NSLog(@"Error while CheckIn save.");
                            }
                        }];
                    }
                }];
            }
        }];
        
        QuizTableViewController *detailViewController = [segue destinationViewController];
        [detailViewController setWaypoint:_waypoint];
    }
    
    if ([[segue identifier] isEqualToString:@"NewPOIComment"])
    {
        // Create a destination controller and add selected waypoint.
        POINewCommentViewController *destinationViewController = [segue destinationViewController];
        [destinationViewController setWaypoint:self.waypoint];
    }
    
    // Segue to show waypoint's comments.
    if ([[segue identifier] isEqualToString:@"ShowPOIComments"])
    {        
        // Create a destination controller and add selected waypoint.
        POICommentTableViewController *commentTableViewController = [segue destinationViewController];
        [commentTableViewController setWaypoint:self.waypoint];
    }
    /*
    // Segue to show waypoint's comments.
    if ([[segue identifier] isEqualToString:@"ShowPOIMapSegue"])
    {
        // Create a destination controller and add selected waypoint.
        MapViewController *mapViewController = [segue destinationViewController];
        [mapViewController.mapView setCenterCoordinate:[self.waypoint coordinate]];
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([self.waypoint coordinate], 1000, 1000);
        [mapViewController.mapView setRegion:region animated:YES];
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
