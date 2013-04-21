//
//  POITableViewCell.m
//  Geogame
//
//  Created by Mathieu Dabek on 20/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "POITableViewCell.h"

@implementation POITableViewCell

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
