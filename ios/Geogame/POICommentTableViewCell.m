//
//  POICommentTableViewCell.m
//  Geogame
//
//  Created by Mathieu Dabek on 12/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "POICommentTableViewCell.h"

@implementation POICommentTableViewCell

@synthesize dateLabel = _dateLabel;
@synthesize titleLabel = _titleLabel;
@synthesize textView = _textView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
