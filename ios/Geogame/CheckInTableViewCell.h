//
//  CheckInTableViewCell.h
//  Geogame
//
//  Created by Mathieu Dabek on 12/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInTableViewCell : UITableViewCell
{
    UILabel* _titleLabel;
    UILabel* _dateLabel;
}

@property(nonatomic, retain) IBOutlet UILabel* titleLabel;
@property(nonatomic, retain) IBOutlet UILabel* dateLabel;

@end
