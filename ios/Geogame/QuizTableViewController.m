//
//  QuizTableViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 07/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "QuizTableViewController.h"
#import "QuizAnswerTableViewController.h"
#import "QuizQuestion.h"

@interface QuizTableViewController ()

@end

@implementation QuizTableViewController

@synthesize waypoint = _waypoint;
@synthesize choices = _choices;

- (void)viewDidLoad
{
    [super viewDidLoad];

    _lockedQuestions = [[NSMutableArray alloc] initWithObjects:NO,NO,NO,NO, nil];
    
    [self loadQuizInBackground];
}

- (IBAction)submitQuiz:(id)submitButton
{
    NSLog(@"Submit quiz");
    
    int score = 0;
    
    for(int i=0; i< [_choices count]; i++)
    {
        if([_choices objectAtIndex:i] == nil)
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"Please complete all the quiz before submit." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
            
            return;
        }
        
        if((int)[_choices objectAtIndex:i] == [[_questions objectAtIndex:i] correctAnswer])
            score++;
    }
    
    if(score == [_questions count])
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Perfect !" message:@"All right !" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [message show];
    }
}

- (void)lockQuestion:(int)question
{
    //[_lockedQuestions setObject:YES atIndexedSubscript:1];
}

- (void)loadQuizInBackground
{
    if ([_waypoint objectId] == nil)
    {
        return;
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Quiz"];
    [query whereKey:@"waypoint" equalTo:_waypoint];
    [query whereKey:@"isEnabled" equalTo:[NSNumber numberWithBool:YES]];
    
    // Find objets in background.
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
    {
        if(!error && [object objectId] != nil)
        {
            PFRelation *questionRelation = [object relationforKey:@"questions"];
            [[questionRelation query] whereKey:@"isEnabled" equalTo:[NSNumber numberWithBool:YES]];
            [[questionRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
             {
                 if (!error)
                 {
                     // Parse all objects.
                     _choices = [[NSMutableArray alloc] initWithCapacity:[objects count]];
                     _questions = [[NSMutableArray alloc] initWithCapacity:objects.count];
                     for (int i = 0 ; i < [objects count] ; i++)
                     {
                         [_questions addObject:[[QuizQuestion alloc] initWithPFObject:[objects objectAtIndex:i]]];
                         //NSLog(@"Objects for id : %@", [(PFObject*)[objects objectAtIndex:i] objectId]);
                     }
                     
                     //NSLog(@"Comments nb : %d", [_comments count]);
                     
                     [self.tableView reloadData];
                 }
                 else
                 {
                     // Log details of the failure
                     NSLog(@"Error: %@ %@", error, [error userInfo]);
                 }
             }];

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
    return [_questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuizQuestionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    QuizQuestion* question = [_questions objectAtIndex:indexPath.row];
    NSLog(@"Question ID : %@", [question objectId]);
    [[cell textLabel] setText:[question name]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to show more informations about a waypoint.
    if ([[segue identifier] isEqualToString:@"ShowQuizQuestionAnswerSegue"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        QuizAnswerTableViewController *detailViewController = [segue destinationViewController];
        QuizQuestion* question = [_questions objectAtIndex:selectedRowIndex.row];
        NSLog(@"Question : %@", [question name]);
        
        [detailViewController setQuestion:question];
        [detailViewController setQuestionNb:selectedRowIndex.row];
        
        //Waypoint* waypoint = [_waypoints objectAtIndex:selectedRowIndex.row];
        //NSLog(@"WP ID : %@", [waypoint objectId]);
    }
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
}

@end
