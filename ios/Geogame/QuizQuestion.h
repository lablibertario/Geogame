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
    NSString* _name;
    NSString* _answerA;
    NSString* _answerB;
    NSString* _answerC;
    NSString* _answerD;
    int _correctAnswer;
}

@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* answerA;
@property(nonatomic, retain) NSString* answerB;
@property(nonatomic, retain) NSString* answerC;
@property(nonatomic, retain) NSString* answerD;
@property(nonatomic) int correctAnswer;

- (id)initWithPFObject:(PFObject*)object;

+ (NSString *)parseClassName;

@end
