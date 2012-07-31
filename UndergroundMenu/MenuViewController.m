//
//  MenuViewController.m
//  UndergroundMenu
//
//  Created by Doug Mason on 8/18/11.
//  Copyright 2011 Doug Mason
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

#import "MenuViewController.h"
#import "FoodTableViewCell.h"
#import "DetailViewController.h"
#import "RootViewController.h"
#import "Menu.h"
@implementation MenuViewController
@synthesize menu,viewController,foodItems;
@synthesize fetchedResultsController = __fetchedResultsController;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]; //TODO: Create different sort descriptor for the 
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    foodItems = [[[menu valueForKey:@"items"] allObjects] sortedArrayUsingDescriptors:sortDescriptors];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"FoCell";
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSLog(@"Cell =  %@",cell);
    if (cell == nil) 
    {
//        cell = [[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.textLabel.text = [[[self.fetchedResultsController objectAtIndexPath:indexPath] valueForKey:@"name"]description];
        NSArray* topLevel = [[NSBundle mainBundle] loadNibNamed:@"MenuItem" owner:self options:nil];
        cell = (FoodTableViewCell*)[topLevel objectAtIndex:0];
    }
    [self configureCell:cell atIndexPath:indexPath];
    
    return  cell;
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    
    DetailViewController* detailView = [[viewController storyboard] instantiateViewControllerWithIdentifier:@"detail"];
    detailView.detailItem =(Food*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    detailView.title = [[[self.fetchedResultsController objectAtIndexPath:indexPath] valueForKey:@"name"] description];
    [self.navigationController pushViewController:detailView animated:YES];
    
}

-(NSFetchedResultsController*)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"menu = %@",self.menu];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Food" inManagedObjectContext:viewController.managedObjectContext]];
    [NSFetchedResultsController deleteCacheWithName:@"Menu"];
    NSFetchedResultsController* aFetchRequestController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.viewController.managedObjectContext sectionNameKeyPath:nil cacheName:@"Menu"];
    aFetchRequestController.delegate = self;
    self.fetchedResultsController = aFetchRequestController;
    NSError* error = nil;
    if(![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Problem! %@,%@",error,[error userInfo]);
        abort();
    }
    return __fetchedResultsController;
}
-(void)configureCell:(FoodTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"%@",managedObject);
    cell.nameLabel.text = [managedObject valueForKey:@"name"];
        NSLog(@"Value for name: %@",[managedObject valueForKey:@"name"]);
    cell.descriptionLabel.text = [[managedObject valueForKey:@"ingredients"] description];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setFormatterBehavior:NSNumberFormatterPadAfterPrefix];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:[managedObject valueForKey:@"price"]]];
    [cell.picture setImage:[UIImage imageWithData:[managedObject valueForKey:@"picture"]]];
    [cell.picture setOpaque:YES];
}
@end
