//
//  ScoreTableViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 14/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "ScoreTableViewController.h"
#import "User.h"
#import <Parse/Parse.h>

@implementation ScoreTableViewController

@synthesize players = _players;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Set up the view.*/
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"backgroundNavigationBar.png"]
     forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];

    
    // Set up refresh control.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadBestScoresInBackground) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;


    [self loadBestScoresInBackground];
}

- (void)loadBestScoresInBackground
{
    // Query for POI retrieving.
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query orderByDescending:@"score"];
    [query setLimit:100];
    
    // Find objets in background.
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // Parse all objects.
             _players = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
             {
                 //NSLog(@"Objects for id : %@", [(PFObject*)[objects objectAtIndex:i] objectForKey:@"objectId"]);
                 [_players addObject:[[User alloc] initWithPFObject:[objects objectAtIndex:i]]];
             }
             
             // Reload table view.
             [self.tableView reloadData];
         }
     }];
    
    [self.refreshControl endRefreshing];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    
    User* user = [_players objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[user username]];
    
    if([[[User currentUser] username] isEqualToString:[user username]])
    {
        NSLog(@"Username : %@ - %@", [[User currentUser] username] , [user username]);
       [[cell textLabel] setTextColor:[UIColor grayColor]];
    }
    
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d points",[user score]]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

@end
