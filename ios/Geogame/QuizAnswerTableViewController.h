//
//  QuizAnswerTableViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 13/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizTableViewController.h"
#import "QuizQuestion.h"

@interface QuizAnswerTableViewController : UITableViewController
{
    QuizQuestion* _question;
    
    QuizTableViewController* _parent;
    
    int _questionNb;
}

@property(nonatomic, retain) QuizQuestion* question;
@property(nonatomic) int questionNb;
@property(nonatomic, retain) QuizTableViewController* parent;

@end
