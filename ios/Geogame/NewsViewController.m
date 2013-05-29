//
//  NewsViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 21/02/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "News.h"
#import "AppDelegate.h"
#import "NewsViewController.h"
#import "NewsDetailViewController.h"
#import "NewsTableViewCell.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize news = _news;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the view.
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"backgroundNavigationBar.png"]
     forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];
    
    
    // Set up refresh control.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadLatestNewsInBackground) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    // Load latest news.
    [self loadLatestNewsInBackground];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    [[cell titleLabel] setText:[[_news objectAtIndex:indexPath.row] title]];
    [[cell textView] setText:[[_news objectAtIndex:indexPath.row] text]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[[_news objectAtIndex:indexPath.row] updatedAt]];
    [[cell dateLabel] setText:stringFromDate];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark -
#pragma mark Table view selection

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"ShowNewsDetails"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        NewsDetailViewController *detailViewController = [segue destinationViewController];
        [detailViewController setNews:[_news objectAtIndex:selectedRowIndex.row]];
    }
}

- (void)loadLatestNewsInBackground
{
    PFQuery *query = [PFQuery queryWithClassName:@"News"];
    
    [query addDescendingOrder:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // The find succeeded.
             //NSLog(@"Successfully retrieved %d news.", objects.count);
             
             // Parse all objects.
             _news = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
                 [_news addObject:[[News alloc] initWithPFObject:[objects objectAtIndex:i]]];
             
             // Reload table view.
             [self.tableView reloadData];
         }
         else
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
    [self.refreshControl endRefreshing];
}

#pragma mark - Actions

- (IBAction)refreshNews:(id)sender
{
    //NSLog(@"Tag gesture on the navigation bar to refresh content.");
    [self loadLatestNewsInBackground];
}


@end
