//
//  WaypointViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "Annotation.h"
#import "WaypointViewController.h"

@implementation WaypointViewController

@synthesize waypoint = _waypoint;
@synthesize nameLabel = _nameLabel;
@synthesize returnButton = _returnButton;
@synthesize checkInButton = _checkInButton;
@synthesize mapView = _mapView;
@synthesize annotations = _annotations;

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [_nameLabel setText:[_waypoint name]];
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = [_waypoint coordinate].latitude;
    newRegion.center.longitude = [_waypoint coordinate].longitude;
    newRegion.span.latitudeDelta = 0.01;
    newRegion.span.longitudeDelta = 0.01;
    _mapView.delegate = self;
    [self.mapView setRegion:newRegion animated:NO];
    
    Annotation *annotation = [[Annotation alloc] initWithWaypoint:_waypoint];
    _annotations = [[NSMutableArray alloc] initWithCapacity:1];
    [_annotations addObject:annotation];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:_annotations];
}

- (IBAction)closeWindow:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)checkInAction:(id)sender
{
    NSLog(@"Check In");
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

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
