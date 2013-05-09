//
//  UserProfileEditPictureViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileEditPictureViewController : UIViewController <UIImagePickerControllerDelegate>
{
    UIImagePickerController *picker;
    IBOutlet UIImageView * selectedImage;
}

@property (nonatomic, retain) UIImageView * selectedImage;

- (IBAction) buttonClicked;

@end
