//
//  Question.m
//  Geogame
//
//  Created by Mathieu Dabek on 19/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>

#import "QuizQuestion.h"

@implementation QuizQuestion

@synthesize name = _name;
@synthesize answerA = _answerA;
@synthesize answerB = _answerB;
@synthesize answerC = _answerC;
@synthesize answerD = _answerD;
@synthesize correctAnswer = _correctAnswer;

- (id)initWithPFObject:(PFObject*)object
{
    if(self = [super init])
    {
        objectId = [object objectId];
    
        _name = [object objectForKey:@"name"];
        _answerA = [object objectForKey:@"answerA"];
        _answerB = [object objectForKey:@"answerB"];
        _answerC = [object objectForKey:@"answerC"];
        _answerD = [object objectForKey:@"answerD"];
        _correctAnswer = [[object objectForKey:@"correctAnswer"] integerValue];
    }
    
    return self;
}

+ (NSString *)parseClassName
{
    return @"QuizQuestion";
}

@end
