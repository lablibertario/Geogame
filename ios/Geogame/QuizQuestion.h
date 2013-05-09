//
//  Question.h
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "QuizAnswer.h"

@interface QuizQuestion : PFObject <PFSubclassing>
{
    NSString* _id;
    NSString* _text;
    QuizAnswer* _trueAnswer;
    NSMutableArray* _answers;
}

+ (NSString *)parseClassName;

@end
