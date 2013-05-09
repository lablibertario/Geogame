//
//  POICommentTableViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 20/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import <Parse/Parse.h>
#import "POICommentTableViewController.h"
#import "POINewCommentViewController.h"
#import "UserComment.h"

@interface POICommentTableViewController ()

@end

@implementation POICommentTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(_waypoint == nil)
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"An error occured" message:@"Cannot load comments, please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [message show];
        
        return;
    }

    // Find waypoint's comments in background.
    PFQuery *query = [PFQuery queryWithClassName:@"UserComment"];
    [query whereKey:@"waypoint" equalTo:_waypoint];
    query.limit = 100;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             // Parse all objects.
             _comments = [[NSMutableArray alloc] initWithCapacity:objects.count];
             for (int i = 0 ; i < [objects count] ; i++)
             {
                 [_comments addObject:[[UserComment alloc] initWithPFObject:[objects objectAtIndex:i]]];
                 NSLog(@"Objects for id : %@", [(PFObject*)[objects objectAtIndex:i] objectForKey:@"objectId"]);
             }
             
             NSLog(@"Comments nb : %d", [_comments count]);
             
             [self.tableView reloadData];
         }
         else
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
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
    return [_comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UserComment* comment = [_comments objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[comment title]];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewPOIComment"])
    {
        // Create a destination controller and add selected waypoint.
        POINewCommentViewController *destinationViewController = [segue destinationViewController];
        [destinationViewController setWaypoint:self.waypoint];
        
        NSLog(@"Selected waypoint : %@", [[destinationViewController waypoint] name]);
    }
}

@end
