//
//  UserProfileEditPictureViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "UserProfileEditPictureViewController.h"


@implementation UserProfileEditPictureViewController

@synthesize selectedImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    //[[Picker parentViewController] dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerController:(UIImagePickerController *) Picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    selectedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //[[Picker parentViewController] dismissModalViewControllerAnimated:YES];
    
}

-(IBAction) buttonClicked
{
    
    picker = [[UIImagePickerController alloc] init];
    
    //picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else
        
    {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    //[self presentModalViewController:picker animated:YES];
    
}

@end
