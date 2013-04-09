//
//  NewsController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class News;

@interface NewsController : NSObject
{
    NSMutableArray* _news;
}

@property(nonatomic, retain) NSMutableArray *news;

- (id)init;

- (void)loadLatestNewsInBackground;

@end
