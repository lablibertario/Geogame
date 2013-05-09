//
//  UserProfileEditPictureViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserProfileEditPictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *picker;
    IBOutlet UIImageView * selectedImage;
    
    User* _user;
}

@property (nonatomic, retain) UIImageView * selectedImage;
@property (nonatomic, retain) User* user;

- (IBAction) buttonClicked;

@end
