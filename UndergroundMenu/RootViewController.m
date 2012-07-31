//
//  RootViewController.m
//  UndergroundMenu
//
//  Created by Doug Mason on 7/5/11.
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
#import <CoreData/CoreData.h>

#import "RootViewController.h"

#import "Food.h"
#import "Location.h"
#import "LocationManager.h"
#import "LocationsViewController.h"
#import "Menu.h"
#import "Restaurant.h"
#import "ResturantTableViewCell.h"
@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController
@synthesize locManager,lastKnownLocation;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) 
    {
        id adelegate = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [adelegate managedObjectContext];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Set up the edit and add buttons.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
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
    NSFetchedResultsController* fetch = self.fetchedResultsController;
    NSArray* array = [fetch fetchedObjects];
    /* UGMenu Testbed Injector
     */
    locManager = [[LocationManager alloc] init];
    locManager.delegate = self;
    [locManager startUpdates];
    if (array.count == 0) 
    {
        
        
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        [formatter setFormatterBehavior:NSNumberFormatterDecimalStyle];
        [formatter setMinimumFractionDigits:2];
        [formatter setMaximumFractionDigits:15];
        Restaurant* new = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
        new.name = @"Test";
        new.about = @"Test restaurant";
        new.bgcolor = [UIColor greenColor];
        new.txtcolor = [UIColor whiteColor];
        NSURL* fileURL = [[NSBundle mainBundle] URLForResource:@"foodlogo" withExtension:@"jpg"];
        //NSURL* fileURL = [docs URLByAppendingPathComponent:@"foodlogo.jpg"];
        
        new.logo = [NSData dataWithContentsOfURL:fileURL];
        Location* locale = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        locale.name =@"Test Location Vancouver Mall Dr.";
        locale.latitude = [NSNumber numberWithFloat:45.657949];
        locale.address = @"";
        locale.longitude = [NSNumber numberWithFloat:-122.594717];
        locale.restaurant = new;
        NSURL* lpicurl = [[NSBundle mainBundle] URLForResource:@"testshop" withExtension:@"jpg"];
        locale.picture = [NSData dataWithContentsOfURL:lpicurl];
        Menu* menu = [NSEntityDescription insertNewObjectForEntityForName:@"Menu" inManagedObjectContext:self.managedObjectContext];
        menu.location = locale;
        menu.name = @"Year around menu.";
        NSDateFormatter* dFormatter = [[NSDateFormatter alloc] init];
        [dFormatter setDateStyle:NSDateFormatterShortStyle];
        menu.dateCreated = [dFormatter dateFromString:@"04/20/2011"];
        Food* foo = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:self.managedObjectContext];
        foo.name = @"Test frozen yogurt";
        foo.calories = [NSNumber numberWithInt:90];
        foo.ingredients = @"Milk \n Sugar \n Delicious, delicious vanilla....\n";
        NSURL* foodURL = [[NSBundle mainBundle] URLForResource:@"pro_vay_101" withExtension:@"jpg"];
        foo.picture = [NSData dataWithContentsOfURL:foodURL];
        foo.price = [NSNumber numberWithFloat:3.53];
        foo.menu = menu;
        Location* loc2 = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        loc2.name = @"Test location 2";
        loc2.address = @"";
        NSURL* loc2url = [[NSBundle mainBundle] URLForResource:@"pizzaparlor" withExtension:@"jpg"];
        loc2.latitude = [NSNumber numberWithFloat:45.626635];
        loc2.longitude = [NSNumber numberWithFloat:-122.583361];
        loc2.picture =[NSData dataWithContentsOfURL:loc2url];
        loc2.restaurant = new;
        Menu* seasonal = [NSEntityDescription insertNewObjectForEntityForName:@"Menu"inManagedObjectContext:self.managedObjectContext];
        seasonal.name = @"Fall menu of awesome";
        seasonal.location = loc2;
        seasonal.dateCreated = [dFormatter dateFromString:@"09/11/2011"];
        Food* fallFoo = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:self.managedObjectContext];
        fallFoo.name = @"Test cake";
        fallFoo.menu = seasonal;
        fallFoo.calories = [NSNumber numberWithFloat:599.4];
        fallFoo.price   = [NSNumber numberWithFloat:6.35];
        NSURL* ffURL = [[NSBundle mainBundle] URLForResource:@"cake" withExtension:@"jpg"];
        fallFoo.picture = [NSData dataWithContentsOfURL:ffURL];
        fallFoo.ingredients = @"Pumpkin\nFlour\nSugar\nBrown Sugar\nButter\nPecans\n";
        NSError* error = nil;
        
        if(![self.managedObjectContext save:&error])
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Unresolvable error %@,%@",error,[error userInfo]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            NSLog(@"Unresolvable error! %@,%@",error,[error userInfo]);
            abort();
        }
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestaurantCell";
    
    ResturantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ResturantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationsViewController *locationsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationView"];
    Restaurant *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    locationsViewController.restaurant = selectedObject;    
    locationsViewController.viewController = self;
    [self.navigationController pushViewController:locationsViewController animated:YES];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
    */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    [NSFetchedResultsController deleteCacheWithName:@"Root"];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
        {
	    /*
	     Replace this implementation with code to handle the error appropriately.

	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


- (void)configureCell:(ResturantTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //cell.textLabel.text = [[managedObject valueForKey:@"name"] description];
    cell.nameLabel.text = [[managedObject valueForKey:@"name"] description];
    NSSet* locations = [managedObject valueForKey:@"locations"];
    cell.descriptionLabel.text =[NSString stringWithFormat:@"%d Locations",[locations count]] ;
    //[cell.picture setImage:[UIImage imageNamed:@"foodlogo.jpg"]];
    [cell.picture setImage:[UIImage imageWithData:[managedObject valueForKey:@"logo"]]];
    [cell.picture setOpaque:YES];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    return;
}

- (void)newPhysicalLocation:(CLLocation *)location {
    
    // Store for later use
    self.lastKnownLocation = location;
    
    // Remove spinner from view
    for (UIView *v in [self.view subviews])
    {
        if ([v class] == [UIActivityIndicatorView class])
        {
            [v removeFromSuperview];
            break;
        }
    }
    
    // Alert user
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Found" message:[NSString stringWithFormat:@"Found physical location.  %f %f", self.lastKnownLocation.coordinate.latitude, self.lastKnownLocation.coordinate.longitude] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    // ... continue with initialization of your app
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) 
    {
        NSLog(@"Button 0 pressed!");
    }
}
#pragma Mark - Utility Functions
-(void)insertNewObject
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"Add menus" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"OK", nil];
    [sheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    [sheet showInView: self.view];
    
}
@end
