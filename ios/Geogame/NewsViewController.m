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

@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize newsController = _newsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the controller of latest news.
    AppDelegate *delegate = [[UIApplication  sharedApplication] delegate];
    _newsController = delegate.newsController;
    
    // Load latest news.
    _newsController = [[NewsController alloc] init];
    [_newsController loadLatestNewsInBackground];
    
    [self.tableView reloadData];
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
    return [[_newsController news] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    [[cell textLabel] setText:[[[_newsController news] objectAtIndex:indexPath.row] title]];
    [[cell detailTextLabel] setText:[[[_newsController news] objectAtIndex:indexPath.row] text]];
    return cell;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
        [detailViewController setNews:[[_newsController news]objectAtIndex:selectedRowIndex.row]];
    }
}

#pragma mark - Actions

- (IBAction)refreshNews:(id)sender
{
    NSLog(@"Tag gesture on the navigation bar to refresh content.");
    [_newsController loadLatestNewsInBackground];
    [_tableView reloadData];
}


@end
