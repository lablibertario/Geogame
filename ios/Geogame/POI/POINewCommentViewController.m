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
        
        [_comment setObject:[_titleTextView text] forKey:@"title"];
        [_comment setBody:[_bodyTextView text]];
        [_comment setObject:[_bodyTextView text] forKey:@"body"];
        [_comment setObject:[NSNumber numberWithBool:NO] forKey:@"isSafe"];
    
        [_comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error)
            {
                // Save user's relation.
                PFUser *user = [PFUser currentUser];
                PFRelation *userRelation = [user relationforKey:@"comments"];
                [userRelation addObject:_comment];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if(!error)
                    {
                        UIAlertView *message = [[UIAlertView alloc]
                                                initWithTitle:@"Comment saved with success"
                                                message:@"Your comment will be available after review."
                                                delegate:nil
                                                cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [message show];
                    }
                }];
                
                // Save waypoint's relation.
                PFRelation *waypointRelation = [_waypoint relationforKey:@"comments"];
                [waypointRelation addObject:_comment];
                [_waypoint saveInBackground];
            }
        }];
    
        //NSLog(@"Comment : %@", [_comment title]);
        //NSLog(@"Comment : %@", [_comment body]);
        //NSLog(@"User : %@", [_user username]);
        //NSLog(@"Waypoint : %@", [[_comment waypoint] name]);
        //[_comment setWaypoint:_waypoint];
        //[_comment setUser: _user];
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
