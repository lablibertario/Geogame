//
//  UserProfileEditPictureViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>

#import "UserEditProfileTableViewController.h"
#import "UserProfileEditPictureViewController.h"


@implementation UserProfileEditPictureViewController

@synthesize selectedImage;
@synthesize user = _user;

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"Start image picker.");
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [self.navigationController popViewControllerAnimated:YES];
  
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, 0.0);
        [imageToUse drawInRect:CGRectMake(0, 0, 200, 200)];
        imageToUse = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        /*
        NSData *imageData = UIImagePNGRepresentation(imageToUse);
        PFFile *imageFile = [PFFile fileWithName:[User currentUser].objectId data:imageData];
        [imageFile save];
        
        PFObject* user = [User currentUser];
        [[User currentUser] setObject:imageFile forKey:@"picture"];
        [user save];
         */
        
        NSData *imageData = UIImagePNGRepresentation(imageToUse);
        PFFile *imageFile = [PFFile fileWithName:[User currentUser].objectId data:imageData];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error)
            {
                PFObject* user = [User currentUser];
                [[User currentUser] setObject:imageFile forKey:@"picture"];
                [user save];
                
                [self.parentViewController reloadInputViews];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        
        
    }
    
    
    
    
    
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

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = delegate;
    
    [self presentViewController:mediaUI animated:NO completion:nil];
    return YES;
}


@end
