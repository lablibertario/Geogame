//
//  DetailViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 12/03/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class PFObject;

@interface DetailViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
