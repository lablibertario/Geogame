//
//  ScoreTableViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 14/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTableViewController : UITableViewController
{
    NSMutableArray* _players;
}

@property(nonatomic,retain) NSMutableArray* players;

@end
