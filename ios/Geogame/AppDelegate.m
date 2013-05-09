//
//  AppDelegate.m
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

#import "Category.h"
#import "Log.h"
#import "Waypoint.h"
#import "User.h"
#import "UserComment.h"
#import "UserPicture.h"
#import "News.h"
#import "Quiz.h"
#import "QuizAnswer.h"
#import "QuizQuestion.h"

#import "LoginViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize newsController = _newsController;
@synthesize waypointController = _waypointController;
@synthesize user = _user;

@synthesize locationManager = _locationManager;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Waypoint registerSubclass];
    [User registerSubclass];
    [UserComment registerSubclass];
    [UserPicture registerSubclass];
    [Quiz registerSubclass];
    [QuizQuestion registerSubclass];
    [QuizAnswer registerSubclass];
    [News registerSubclass];
    [Category registerSubclass];
    [Log registerSubclass];
    
    // Setup auth with Parse, Facebook and Twitter.
    [Parse setApplicationId:@"3XwbhTy5xG8aB2w3R13MWIopSrDT8e8VNuVczaww" clientKey:@"gpsOemsV8zDZQ8l9oh4tvmyCBxITBXPaqO7kRdQG"];
    //[PFFacebookUtils initializeWithApplicationId:@"488060031252333"];
    //[PFTwitterUtils initializeWithConsumerKey:@"your_twitter_consumer_key" consumerSecret:@"your_twitter_consumer_secret"];
    
    // Set default ACLs
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    // Init user object.
    _user = [[User alloc] init];
    
    // Location manager.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
    // App tracking.
    //[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // Ignore if new locaiton is near old location.
    if([oldLocation distanceFromLocation:newLocation] < 2)
        return;
    
    NSLog(@"Location counter : %d", _locationCounter);
    
    // Save every 10 updates.
    while(_locationCounter++ < 10) return;
    
    // Reset counter.
    _locationCounter = 0;
    
    // Update.
    // Create the object.

    PFGeoPoint* currentUserLocation = [[PFGeoPoint alloc] init];
    [currentUserLocation setLatitude:newLocation.coordinate.latitude];
    [currentUserLocation setLongitude:newLocation.coordinate.longitude];
    
    [[User currentUser] setObject:currentUserLocation forKey:@"location"];

    //[[User currentUser] saveInBackground];
    
    PFObject* user = [User currentUser];
    [user setObject:currentUserLocation forKey:@"location"];
    [user saveInBackground];
                      
    
}

@end
