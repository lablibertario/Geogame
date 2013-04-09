//
//  NewsDetailViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "News.h"
#import "NewsDetailViewController.h"

@implementation NewsDetailViewController

@synthesize news = _news;
@synthesize navigationTextItem = _navigationTextItem;
@synthesize textView = _textView;
@synthesize titleLabel = _titleLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load all content in UI.
    [_titleLabel setText:[_news title]];
    [_navigationTextItem setTitle:[_news title]];
    [_textView setText:[_news text]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
