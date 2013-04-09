//
//  NewsDetailViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface NewsDetailViewController : UIViewController
{
    News* _news;
    
    UITextView *_textView;
    UILabel *_titleLabel;
    UINavigationItem *_navigationTextItem;
}

@property(nonatomic, strong) News *news;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet UINavigationItem *navigationTextItem;
@property(nonatomic, retain) IBOutlet UITextView *textView;


@end
