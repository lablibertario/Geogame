//
//  POINewCommentViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserComment.h"

@interface POINewCommentViewController : UIViewController <UITextViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{    
    UserComment* _comment;
    Waypoint* _waypoint;
    
    UILabel* _titleLabel;
    UITextView* _titleTextView;
    UILabel* _bodyLabel;
    UITextView* _bodyTextView;
    UISwitch* _acceptLicenseAgreementSwitch;
    UIButton* _sendButton;
}

@property(nonatomic, retain) User* user;
@property(nonatomic, retain) Waypoint* waypoint;

@property(nonatomic, retain) IBOutlet UILabel* titleLabel;
@property(nonatomic, retain) IBOutlet UITextView* titleTextView;
@property(nonatomic, retain) IBOutlet UILabel* bodyLabel;
@property(nonatomic, retain) IBOutlet UITextView* bodyTextView;
@property(nonatomic, retain) IBOutlet UISwitch* acceptLicenseAgreementSwitch;
@property(nonatomic, retain) IBOutlet UIButton* sendButton;

- (IBAction)saveInBackground:(id)sendButton;

@end
