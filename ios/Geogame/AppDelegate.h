//
//  AppDelegate.h
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
#import "NewsController.h"
#import "WaypointController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow* _window;
    NewsController *_newsController;
    WaypointController *_waypointController;
    
    User *_user;
    PFUser *_currentUser;
}

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) NewsController *newsController;
@property (nonatomic, strong) WaypointController *waypointController;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) PFUser *currentUser;

@end
