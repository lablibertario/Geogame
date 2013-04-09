//
//  FirstViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "FirstViewController.h"

#import "Waypoint.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Test parse.
    /*
    PFObject *testObject = [PFObject objectWithClassName:@"Test"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject saveInBackground];*/
    
    PFQuery *query = [PFQuery queryWithClassName:@"Waypoint"];
    PFObject *object = [query getFirstObject];
    
    Waypoint* w = [[Waypoint alloc] initWithPFObject:object];
    NSLog([w toString]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
