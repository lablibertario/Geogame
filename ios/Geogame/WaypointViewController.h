//
//  WaypointViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Waypoint.h"

@interface WaypointViewController : UIViewController <MKMapViewDelegate>
{
    Waypoint *_waypoint;
    
    UILabel *_nameLabel;
    UIBarButtonItem *_returnButton;
    UIBarButtonItem *_checkInButton;
    UITextView *_descriptiontextView;
    MKMapView *_mapView;
    
    NSMutableArray *_annotations;
}

@property(nonatomic, retain) Waypoint *waypoint;

@property(nonatomic, retain) IBOutlet UIBarButtonItem *checkInButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *returnButton;
@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property(nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) NSMutableArray *annotations;


- (IBAction)closeWindow:(id)sender;

- (IBAction)checkInAction:(id)sender;

@end
