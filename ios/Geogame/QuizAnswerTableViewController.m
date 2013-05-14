//
//  QuizAnswerTableViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 13/05/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//

#import "QuizAnswerTableViewController.h"

@implementation QuizAnswerTableViewController

@synthesize question = _question;
@synthesize parent = _parent;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Question : %@", [_question name]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
            break;
            
        case 1:
            return 4;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuizAnswerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    switch ([indexPath section])
    {
        case 0:
            [[cell textLabel] setText:[_question name]];
            break;
        case 1:
            switch (indexPath.row)
        {
            case 0:
                [[cell textLabel] setText:[_question answerA]];
                break;
            case 1:
                [[cell textLabel] setText:[_question answerB]];
                break;
            case 2:
                [[cell textLabel] setText:[_question answerC]];
                break;
            case 3:
                [[cell textLabel] setText:[_question answerD]];
                break;

                    
                default:
                    break;
            }
                        
        default:
            break;
    }
    
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
    int correctAnswer = [_question correctAnswer];
    int selectedAnswer = 0;
    
    switch ([indexPath section])
    {
        case 0:
            break;
        case 1:
            switch (indexPath.row)
        {
            case 0:
                
                break;
            case 1:
                selectedAnswer = 1;
                break;
            case 2:
                selectedAnswer = 2;
                break;
            case 3:
                selectedAnswer = 3;
                break;
            case 4:
                selectedAnswer = 4;
                break;
                
            default:
                break;
        }
        default:
            break;
    }
    
    if (correctAnswer == selectedAnswer)
    {
        NSLog(@"Correct !");
    }
    
    //[_parent lockQuestion:selectedAnswer];
    
    //QuizTableViewController* parent = (QuizTableViewController*) self.parentViewController;
    //[[parent choices] setObject:[NSNumber numberWithInt:selectedAnswer] atIndexedSubscript:_questionNb];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
