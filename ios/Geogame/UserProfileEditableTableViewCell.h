//
//  UserProfileEditableTableViewCell.h
//  Geogame
//
//  Created by Mathieu Dabek on 10/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileEditableTableViewCell : UITableViewCell
{
    UITextField* _textField;
}

@property(nonatomic, retain) IBOutlet UITextField* textField;

@end
