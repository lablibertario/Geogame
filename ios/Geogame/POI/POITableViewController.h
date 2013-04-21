//
//  POITableViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 20/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "User.h"

@interface POITableViewController : UITableViewController  <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    AppDelegate* _appDelegate;
    
    User* _user;
    NSMutableArray* _waypoints;
}

@property(nonatomic, retain) User* user;
@property(nonatomic, retain) NSMutableArray* waypoints;



@end
