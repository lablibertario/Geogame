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
    
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"backgroundNavigationBar.png"]
     forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BgLeather.png"]];
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
    switch ([indexPath section])
    {
        case 0:
            break;
        case 1:
            switch (indexPath.row)
        {
            case 0:
                //[[_parent choices] insertObject:@"1" atIndex:_questionNb];
                [[_parent choices] addObject:@"1"];
                [[[[_parent tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_questionNb inSection:0]] detailTextLabel] setText:[_question answerA]];
                break;
            case 1:
                //[[_parent choices] insertObject:@"2" atIndex:_questionNb];
                [[_parent choices] addObject:@"2"];
                [[[[_parent tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_questionNb inSection:0]] detailTextLabel] setText:[_question answerB]];
                break;
            case 2:
                //[[_parent choices] insertObject:@"3" atIndex:_questionNb];
                [[_parent choices] addObject:@"3"];
                [[[[_parent tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_questionNb inSection:0]] detailTextLabel] setText:[_question answerC]];
                break;
            case 3:
                //[[_parent choices] insertObject:@"4" atIndex:_questionNb];
                [[_parent choices] addObject:@"4"];
                [[[[_parent tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_questionNb inSection:0]] detailTextLabel] setText:[_question answerD]];
                break;
                
            default:
                break;
        }
        default:
            break;
    }
    
    NSLog(@"Choice : %@", [[_parent choices] objectAtIndex:_questionNb]);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
