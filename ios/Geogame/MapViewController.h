//
//  MapViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>

#import "Waypoint.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView* _mapView;
    UIBarButtonItem* _refreshMapButton;
    WaypointController *_waypointController;
    NSMutableArray *_annotations;
    UITabBar *_tabBar;
    UINavigationBar *_navigationBar;
}

@property(nonatomic, strong) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic, strong) IBOutlet UITabBar *tabBar;
@property(nonatomic, strong) IBOutlet MKMapView* mapView;
@property(nonatomic, strong) IBOutlet UIBarButtonItem* refreshMapButton;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic, strong) WaypointController *waypointController;
@property(nonatomic, retain) NSMutableArray *annotations;

- (IBAction)refreshMap:(id)sender;

- (IBAction)changeMapType:(id)sender;

- (IBAction)showNavigationBar:(id)sender;

- (IBAction)swipeMap:(id)sender;

@end
