//
//  POICommentTableViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 20/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waypoint.h"

@interface POICommentTableViewController : UITableViewController  <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    NSMutableArray* _comments;
    Waypoint* _waypoint;
}

@property(nonatomic, retain) NSMutableArray* comments;
@property(nonatomic, retain) Waypoint* waypoint;

@end
