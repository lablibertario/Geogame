//
//  POITableViewCell.h
//  Geogame
//
//  Created by Mathieu Dabek on 20/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POITableViewCell : UITableViewCell
{
    UILabel* _waypointNameLabel;
    UIImageView* _waypointImageView;
    
}

@property(nonatomic, retain) IBOutlet UILabel* waypointNameLabel;
@property(nonatomic, retain) IBOutlet UIImageView* waypointImageView;

@end
