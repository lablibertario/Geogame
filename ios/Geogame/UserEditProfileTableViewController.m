//
//  UserEditProfileTableViewController.m
//  Geogame
//
//  Created by Mathieu Dabek on 23/04/13.
//  Copyright (c) 2013 Mathieu Dabek. All rights reserved.
//



#import "AppDelegate.h"

#import "UserEditProfileTableViewController.h"
#import "UserProfileEditPictureViewController.h"
#import "UserPictureTableViewCell.h"
#import "UserProfileDeleteTableCell.h"
#import "UserProfileEditableTableViewCell.h"

@implementation UserEditProfileTableViewController

@synthesize user = _user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _user = (User*)[User currentUser];
    
    [_user addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionOld context:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //NSLog(@"User changed.");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    switch(section)
    {
        // User's picture.
        case 0:
            return 1;
            break;
            
        // User's profile.
        case 1:
            return 3;
            break;
            
        // User's personal details.
        case 2:
            return 3;
            break;
        
        // Delete account.
        case 3:
            return 1;
            break;
            
        // Default.
        default:
            return 0;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"Picture";
            break;
        case 1:
            return @"Profile";
            break;
        
        case 2:
            return @"Personal details";
            break;
        default:
            return nil;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch([indexPath section])
    {
        // User's profile picture.
        case 0:
        {
            static NSString *CellIdentifier = @"UserProfileImageCell";
            UserPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
            if (cell == nil)
                cell = [[UserPictureTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
            // Load user picture.
            PFImageView *imageView = [[PFImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"image-example.png"];
            imageView.file = (PFFile *)[_user objectForKey:@"picture"];
            [imageView loadInBackground:^(UIImage *image, NSError *error) {
                [[cell userImageView] setImage:imageView.image];
                [[cell userImageView] reloadInputViews];
            }];

            return cell;
        }
        
        // User's profile.
        case 1:
        {

            switch(indexPath.row)
            {
                // User's username.
                case 0:
                {
                    static NSString *CellIdentifier = @"UserProfileTextCell";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    if (cell == nil)
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                    [[cell textLabel] setText:@"Username"];
                    [[cell detailTextLabel] setText:[_user username]];
                    
                    return cell;
                }
                    
                // User's email.
                case 1:
                {
                    static NSString *CellIdentifier = @"UserProfileEditableCell";
                    UserProfileEditableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    if (cell == nil)
                        cell = [[UserProfileEditableTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                    [[cell textLabel] setText:@"Email"];
                    [[cell textField] setText:[[User currentUser] objectForKey:@"email"]];
                    
                    return cell;
                }
                    
                // User's location.
                case 2:
                {
                    static NSString *CellIdentifier = @"UserProfileLocationCell";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    if (cell == nil)
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                    [[cell textLabel] setText:@"Location"];
                    [[cell detailTextLabel] setText:[[User currentUser] objectForKey:@"city"]];
                    
                    return cell;
                }
            }
        }
            
        // User's personal details.
        case 2:
        {
            switch (indexPath.row)
            {
                // User's firstname.
                case 0:
                {
                    static NSString *CellIdentifier = @"UserProfileTextCell";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    if (cell == nil)
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                    [[cell textLabel] setText:@"Firstname"];
                    [[cell detailTextLabel] setText:[_user objectForKey:@"firstname"]];
                    
                    return cell;
                    break;
                }
                    
                // User's lastname.
                case 1:
                {
                    static NSString *CellIdentifier = @"UserProfileTextCell";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    if (cell == nil)
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                    [[cell textLabel] setText:@"Lastname"];
                    [[cell detailTextLabel] setText:[[User currentUser] objectForKey:@"lastname"]];
                    //[[cell detailTextLabel] setText:@"TEST"];
                    return cell;
                    break;
                }
                    
                // User's birthday
                case 2:
                {
                    static NSString *CellIdentifier = @"UserProfileTextCell";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    if (cell == nil)
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                    [[cell textLabel] setText:@"Birthday"];
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"dd/MM/yyyy"];
                    NSString *stringFromDate = [formatter stringFromDate:[[User currentUser] objectForKey:@"birthday"]];
                    [[cell detailTextLabel] setText:stringFromDate];
                    
                    return cell;
                    break;
                }
                    
                default:
                    break;
            }
        }
            
        case 3:
        {
            static NSString *CellIdentifier = @"UserProfileDeleteCell";
            UserProfileDeleteTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            if (cell == nil)
                cell = [[UserProfileDeleteTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    }
    
    static NSString *CellIdentifier = @"UserProfileTextCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    return cell;

}

- (GLfloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    switch([indexPath section])
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                return 120.0f;
            }
        }
        default:
            return 44.0f;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section])
    {
        // User's picture.
        case 0:
        {

        }
        default:
            break;
    }
    
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
    if ([[segue identifier] isEqualToString:@"ShowUserPictureSegue"])
    {
        // Create a destination controller and add selected waypoint.
        UserProfileEditPictureViewController *destinationViewController = [segue destinationViewController];
        [destinationViewController setUser:_user];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



@end
