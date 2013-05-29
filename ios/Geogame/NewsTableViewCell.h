//
//  NewsTableViewCell.h
//  Geogame
//
//  Created by Mathieu Dabek on 16/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
{
    UILabel* _titleLabel;
    UILabel* _dateLabel;
    UITextView* _textView;
}

@property(nonatomic,retain) IBOutlet UILabel* titleLabel;
@property(nonatomic,retain) IBOutlet UILabel* dateLabel;
@property(nonatomic,retain) IBOutlet UITextView* textView;

@end
