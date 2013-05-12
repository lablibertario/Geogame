//
//  SignUpViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.signUpView.logo = [[UIView alloc] init];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, 150, 30)];
    
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Geogame.png"]];
    [view addSubview:image];
    self.signUpView.logo = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
