//
//  POINewCommentViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "POINewCommentViewController.h"

@implementation POINewCommentViewController

@synthesize waypoint = _waypoint;

@synthesize titleLabel = _titleLabel;
@synthesize titleTextView = _titleTextView;
@synthesize bodyLabel = _bodyLabel;
@synthesize bodyTextView = _bodyTextView;
@synthesize acceptLicenseAgreementSwitch = _acceptLicenseAgreementSwitch;
@synthesize sendButton = _sendButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate;
    _user = [appDelegate user];
    
    [_titleTextView setDelegate:self];
    [_bodyTextView setDelegate:self];
    
    _comment = [[UserComment alloc] init];
}

#pragma mark - Actions.

- (IBAction)saveInBackground:(UIStoryboardSegue *)segue;
{
        if(![_acceptLicenseAgreementSwitch isOn])
        {
            UIAlertView *message = [[UIAlertView alloc]
                                    initWithTitle:@"Accept license agreement"
                                    message:@"Please accept the end-user license agreeement."
                                    delegate:nil
                                    cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
            
            return;
        }
        
        [_comment setTitle:[_titleTextView text]];
        [_comment setBody:[_bodyTextView text]];
    
        NSLog(@"Comment : %@", [_comment title]);
        NSLog(@"Comment : %@", [_comment body]);
        NSLog(@"User : %@", [_user username]);
        NSLog(@"Waypoint : %@", [[_comment waypoint] name]);
    
        [_comment setWaypoint:_waypoint];
        [_comment setUser: _user];
        
        [_comment saveAsPFObjectInBackground];
        
        UIAlertView *message = [[UIAlertView alloc]
                            initWithTitle:@"Comment saved with success"
                            message:@"Your comment will be available after review."
                            delegate:nil
                            cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [message show];
}


#pragma mark - Keyboard delegate.

- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
