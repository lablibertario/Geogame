//
//  UserPictureTableViewCell.h
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPictureTableViewCell : UITableViewCell
{
    UIImageView* _userImageView;
}

@property(nonatomic,retain) IBOutlet UIImageView* userImageView;

@end
