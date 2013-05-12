//
//  POICommentTableViewCell.h
//  Geogame
//
//  Created by Mathieu Dabek on 12/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POICommentTableViewCell : UITableViewCell
{
    UILabel* _dateLabel;
    UILabel* _titleLabel;
    UITextView* _textField;
}

@property(nonatomic, retain) IBOutlet UILabel* dateLabel;
@property(nonatomic, retain) IBOutlet UILabel* titleLabel;
@property(nonatomic, retain) IBOutlet UITextView* textView;

@end
