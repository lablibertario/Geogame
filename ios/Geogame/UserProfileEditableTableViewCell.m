//
//  UserProfileEditableTableViewCell.m
//  Geogame
//
//  Created by Mathieu Dabek on 10/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "UserProfileEditableTableViewCell.h"

@implementation UserProfileEditableTableViewCell

@synthesize textField = _textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
