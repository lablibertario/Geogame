//
//  UserPictureTableViewCell.m
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "UserPictureTableViewCell.h"

@implementation UserPictureTableViewCell

@synthesize userImageView = _userImageView;

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
