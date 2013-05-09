//
//  SearchViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "SearchViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *delegate;
    
    if (![delegate user])
    {
        LoginViewController *logInController = [[LoginViewController alloc] init];
        logInController.delegate = self;
        
        [self presentViewController:logInController animated:YES completion:nil];
    }

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
