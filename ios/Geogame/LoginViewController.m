//
//  LoginViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 18/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *fieldsBackground;

@end

@implementation LoginViewController

@synthesize parentController = _parentController;
@synthesize fieldsBackground;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.logInView.logo = [[UIView alloc] init];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, 150, 30)];

    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Geogame.png"]];
    [view addSubview:image];
    self.logInView.logo = view;
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:
    //                             [UIImage imageNamed:@"BgLeather.png"]];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
