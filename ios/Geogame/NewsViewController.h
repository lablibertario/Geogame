//
//  NewsViewController.h
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsController.h"

@interface NewsViewController : UITableViewController  <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    NSMutableArray* _news;
    UITableView *_tableView;
    
}

@property(nonatomic, retain) NSMutableArray *news;
@property(nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction)refreshNews:(id)sender;


@end
