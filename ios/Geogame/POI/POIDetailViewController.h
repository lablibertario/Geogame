//
//  POIDetailViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Waypoint.h"

@interface POIDetailViewController : UIViewController<MKMapViewDelegate>
{
    Waypoint* _waypoint;
    
    UILabel* _waypointNameLabel;
    MKMapView* _waypointMapView;
    UIImageView* _waypointImageView;
    UITextView* _waypointDescriptionTextView;
}

@property(nonatomic, retain) Waypoint* waypoint;
@property(nonatomic, retain) IBOutlet UILabel* waypointNameLabel;
@property(nonatomic, retain) IBOutlet MKMapView* waypointMapView;
@property(nonatomic, retain) IBOutlet UIImageView* waypointImageView;
@property(nonatomic, retain) IBOutlet UITextView* waypointDescriptionTextView;

@end
