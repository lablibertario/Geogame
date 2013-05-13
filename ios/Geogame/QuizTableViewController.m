//
//  QuizTableViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 07/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "QuizTableViewController.h"
#import "QuizQuestion.h"

@interface QuizTableViewController ()

@end

@implementation QuizTableViewController

@synthesize waypoint = _waypoint;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //_quiz = [[Quiz alloc] init];
}

- (void)loadQuizInBackground
{
    PFQuery *query = [PFQuery queryWithClassName:@"Quiz"];
    //[query includeKey:@"objectId"];
    [query whereKey:@"waypoint" equalTo:_waypoint];
    [query whereKey:@"isEnabled" equalTo:[NSNumber numberWithBool:YES]];
    
    // Find objets in background.
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        /*
        PFObject* quiz = [objects objectAtIndex:1];
        PFQuery *query = [PFQuery queryWithClassName:@"Quiz"];
        //[query includeKey:@"objectId"];
        [query whereKey:@"waypoint" equalTo:_waypoint];
        [query whereKey:@"isEnabled" equalTo:[NSNumber numberWithBool:YES]];
        
        if (!error)
        {
            // Parse all objects.
            _ = [[NSMutableArray alloc] initWithCapacity:objects.count];
            for (int i = 0 ; i < [objects count] ; i++)
            {
                //NSLog(@"Objects for id : %@", [(PFObject*)[objects objectAtIndex:i] objectForKey:@"objectId"]);
                [_questions addObject:[[QuizQuestion alloc] initWithPFObject:[objects objectAtIndex:i]]];
            }
            
            // Reload table view.
            [self.tableView reloadData];
        }
        else
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"Unable to load nearest waypoints. Please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
            return;
            
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
         
        */ 

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
    return [_questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuizQuestionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
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
