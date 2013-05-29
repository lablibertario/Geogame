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
#import "User.h"

@interface QuizTableViewController ()

@end

@implementation QuizTableViewController

@synthesize waypoint = _waypoint;
@synthesize choices = _choices;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"backgroundNavigationBar.png"]
     forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];
    
   

    _lockedQuestions = [[NSMutableArray alloc] initWithObjects:NO,NO,NO,NO, nil];
    
    [self loadQuizInBackground];
}

- (IBAction)submitQuiz:(id)submitButton
{
    NSLog(@"Submit quiz");
    
    PFRelation *userRelation = [[User currentUser] relationforKey:@"quizs"];
    [[userRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            if ([objects count] > 0) {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"Quiz already submited !." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [message show];
                return;
            }
            else
            {

    
    int score = 0;
    NSLog(@"Choices nb : %d", [_choices count]);
    for(int i=0; i < [_choices count]; i++)
    {
        NSLog(@" %d", i);
        if([[_choices objectAtIndex:i] isEqualToString:@""])
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oups !" message:@"Please complete all the quiz before submit." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
            
            return;
        }
        
        NSLog(@"Choice : %@", [_choices objectAtIndex:i]);
        NSLog(@"Correct answer : %@", [NSString stringWithFormat:@"%d",[[_questions objectAtIndex:i] correctAnswer]]);
        
        if([[_choices objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d",[[_questions objectAtIndex:i] correctAnswer]]])
        {
            score++;
            NSLog(@"Good !");
        }
        
        NSLog(@"Score %d", score);
    }
    
    score *= 5;

        PFObject* userQuiz = [PFObject objectWithClassName:@"UserQuiz"];
        
        [userQuiz setObject:[NSString stringWithFormat:@"%d", score ] forKey:@"score"];
        [userQuiz setObject:[[User currentUser] username] forKey:@"username"];
        
        [userQuiz saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error)
            {
                // Save user's relation.
                PFUser *user = [PFUser currentUser];
                PFRelation *userRelation = [user relationforKey:@"quizs"];
                [userRelation addObject:userQuiz];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if(!error)
                    {
                        // Update user's score.
                        PFUser *user = [PFUser currentUser];
                        int userScore = [[user objectForKey:@"score"] integerValue];
                        userScore += score;
                        [user setObject:[NSString stringWithFormat:@"%d", userScore] forKey:@"score"];
                        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if(!error)
                            {
                                UIAlertView *message = [[UIAlertView alloc]
                                                        initWithTitle:@"Quiz saved with success"
                                                        message:[NSString stringWithFormat:@"You got %d points.", score]
                                                        delegate:nil
                                                        cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                [message show];
                                
                                [self correctQuiz];
                                /*
                                // Save waypoint's relation.
                                PFRelation *waypointRelation = [_waypoint relationforKey:@"quizs"];
                                [waypointRelation addObject:userQuiz];
                                [_waypoint saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                    if(!error)
                                    {
                                        UIAlertView *message = [[UIAlertView alloc]
                                                                initWithTitle:@"Quiz saved with success"
                                                                message:[NSString stringWithFormat:@"You got %d points.", score]
                                                                delegate:nil
                                                                cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                        [message show];

                                    }
                                    else
                                        NSLog(@"Error while saving waypoint relation.");
                                }];
                                */
                                                                
                            }
                            else
                                NSLog(@"Error while saving user score.");
                        }];
                        
                    }
                    else
                        NSLog(@"Error while saving user relation.");
                }];
                
                
            }
        }];
            }
        }
        }];

}

- (void)correctQuiz
{
    for(int i=0; i < [_choices count]; i++)
    {        
        NSLog(@"Choice : %@", [_choices objectAtIndex:i]);
        NSLog(@"Correct answer : %@", [NSString stringWithFormat:@"%d",[[_questions objectAtIndex:i] correctAnswer]]);
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if([[_choices objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d",[[_questions objectAtIndex:i] correctAnswer]]])
        {
            
            [[cell detailTextLabel] setTextColor:[UIColor greenColor]];
            
            NSLog(@"Good !");
        }
        else
        {
            [[cell detailTextLabel] setTextColor:[UIColor redColor]];
        }
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
                     NSLog(@"NB questions %d", [_choices count]);
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
        [detailViewController setParent:self];
        
        //Waypoint* waypoint = [_waypoints objectAtIndex:selectedRowIndex.row];
        
        NSLog(@"Q ID : %@", [[detailViewController question] name]);
        NSLog(@"Q NB : %d", [detailViewController questionNb]);
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
