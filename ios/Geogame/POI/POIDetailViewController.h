//
//  POIDetailViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

#import "Waypoint.h"

@interface POIDetailViewController : UIViewController<MKMapViewDelegate>
{
    Waypoint* _waypoint;
    
    UILabel* _waypointNameLabel;
    UILabel* _waypointReferenceLabel;
    MKMapView* _waypointMapView;
    UIImageView* _waypointImageView;
    UITextView* _waypointDescriptionTextView;
    
    UIButton* _checkInButton;
    UIButton* _showCommentsButton;
}

@property(nonatomic, retain) Waypoint* waypoint;
@property(nonatomic, retain) IBOutlet UILabel* waypointNameLabel;
@property(nonatomic, retain) IBOutlet UILabel* waypointReferenceLabel;
@property(nonatomic, retain) IBOutlet MKMapView* waypointMapView;
@property(nonatomic, retain) IBOutlet UIImageView* waypointImageView;
@property(nonatomic, retain) IBOutlet UITextView* waypointDescriptionTextView;

@property(nonatomic, retain) IBOutlet UIButton* checkInButton;
@property(nonatomic, retain) IBOutlet UIButton*  showCommentsButton;

- (IBAction)checkInAction:(UIButton*)checkInButton;

- (IBAction)showCommentsAction:(UIButton*)showCommentsButton;

@end
