//
//  QuizTableViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 07/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Waypoint.h"
#import "Quiz.h"

@interface QuizTableViewController : UITableViewController
{
    Waypoint* _waypoint;
    NSMutableArray* _questions;
    NSMutableArray* _choices;
    
    NSMutableArray* _lockedQuestions;
}

@property(nonatomic,retain) Waypoint* waypoint;
@property(nonatomic, retain) NSMutableArray* choices;

- (void)lockQuestion:(int)question;

- (IBAction)submitQuiz:(id)submitButton;


@end
