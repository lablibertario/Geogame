//
//  POIDetailViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "POIDetailViewController.h"
#import "Annotation.h"

@implementation POIDetailViewController

@synthesize waypoint = _waypoint;
@synthesize waypointNameLabel = _waypointNameLabel;
@synthesize waypointMapView = _waypointMapView;
@synthesize waypointImageView = _waypointImageView;
@synthesize waypointDescriptionTextView = _waypointDescriptionTextView;

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
