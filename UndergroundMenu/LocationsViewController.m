//
//  LocationsViewController.m
//  UndergroundMenu
//
//  Created by Doug Mason on 8/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>

#import "LocationsViewController.h"
#import "Restaurant.h"
#import "LocationTableViewCell.h"
#import "RootViewController.h"
#import "Location.h"
#import "MenuViewController.h"
#import "Menu.h"
#import "MenuSelectViewController.h"
@implementation LocationsViewController
@synthesize restaurant;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize viewController;
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
    [self.tableView reloadData];
    [self.tableView setNeedsDisplay];
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
    NSArray* arr = [self.fetchedResultsController fetchedObjects];
    for (Location* loc in arr) {
        if(!loc.distance)
        {
            CLLocation* place = [[CLLocation alloc] initWithLatitude:[loc.latitude floatValue] longitude:[loc.longitude floatValue]];
            loc.distance = [NSNumber numberWithDouble:[self.viewController.lastKnownLocation distanceFromLocation:place]];
        }
        if([loc.address compare:@""] ==NSOrderedSame)
        {
            CLLocation* cll = [[CLLocation alloc] initWithLatitude:[loc.latitude floatValue] longitude:[loc.longitude floatValue]];
            CLGeocoder* geo = [[CLGeocoder alloc] init];
            [geo reverseGeocodeLocation:cll completionHandler:
             ^(NSArray* placemarks,NSError* error)
             {
                 NSManagedObjectContext* context = [[NSManagedObjectContext alloc] init];
                 [context setPersistentStoreCoordinator:[self.viewController.managedObjectContext persistentStoreCoordinator]];
                 NSFetchRequest* fetch = [[NSFetchRequest alloc] init];
                 
                 [fetch setEntity:[NSEntityDescription entityForName:@"Location" inManagedObjectContext:context]];
                 [fetch setReturnsObjectsAsFaults:NO];
                 NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name LIKE %@",loc.name];
                 [fetch setPredicate:predicate];
                 NSArray* locations = [context executeFetchRequest:fetch error:nil];
                 if([locations count] > 0)
                 {
                     Location* current = (Location*)[locations objectAtIndex:0];
                     if ([placemarks count] > 0)
                     {
                         CLPlacemark* place = [placemarks objectAtIndex:0];
                         [current setValue:[NSString stringWithFormat:@"%@ %@ %@,%@",place.subThoroughfare,place.thoroughfare,place.locality,place.administrativeArea] forKey:@"address" ];
                         NSLog(@"Current address after Geocode update: %@",[[current valueForKey:@"address"] description]);
                     }
                 }
                 NSError* err = nil;
                 if (![context save:&err]) 
                 {
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[NSString stringWithFormat:@"%@, %@",error,[error userInfo]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                     [alert show];
                 }
             }];
        }
    }
    self.navigationItem.title = restaurant.name;
    [self.navigationController.navigationBar setTintColor:restaurant.bgcolor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:restaurant.txtcolor forKey:UITextAttributeTextColor]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NSFetchedResultsController deleteCacheWithName:@"Locations"];
    if( ![self.fetchedResultsController fetchedObjects])
    {
        NSLog(@"Oops");
    }
    NSError* err = nil;
    if(![self.fetchedResultsController performFetch:&err])
    {
    }
    [(UITableView*)viewController.view reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LocationCell";
    
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSLog(@"%@",cell);
    if (cell == nil) {
        cell = [[LocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
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
    NSManagedObject* location = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    NSSet* set = [location valueForKey:@"menus"];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray* menus = [[set allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    if ([menus count] == 1) { //If there is only one menu available to the restaurant location
        Menu* theMenu = (Menu*)[menus objectAtIndex:0];
        MenuViewController* menuController = [[MenuViewController alloc] init];
        menuController.title = theMenu.name;
        menuController.menu = theMenu;
        menuController.viewController = self.viewController;
        [self.viewController.navigationController pushViewController:menuController animated:YES];
    }
    else
    {
        Location* locale = (Location*) location;
        MenuSelectViewController* selectView = [[MenuSelectViewController alloc] init];
        selectView.title = locale.name;
        selectView.location = locale;
        selectView.viewController = self.viewController;
        [self.viewController.navigationController pushViewController:selectView animated:YES];
    }
}

#pragma mark - Fetched Results Controller Delegate

-(NSFetchedResultsController*) fetchedResultsController
{
    if (__fetchedResultsController != nil) 
    {
        return __fetchedResultsController;
    } 
    
    /*
     Set up the fetched results controller.
     */
    [NSFetchedResultsController deleteCacheWithName:@"Locations"];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObject* obj = (NSManagedObject*) restaurant;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"restaurant = %@",obj];
    [fetchRequest setPredicate:predicate];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.viewController.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES selector:@selector(compare:)];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.viewController.managedObjectContext sectionNameKeyPath:nil cacheName:@"Locations"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Fetched Results Error!" message:[NSString stringWithFormat:@"%@ %@, please hit the home button to quit the application.",error,[error userInfo]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	    [alert show];
	}
    
    for (NSManagedObject* object in [self.fetchedResultsController fetchedObjects]) {
        NSLog(@"%@",object);
    }
    return __fetchedResultsController;
}

- (void)configureCell:(LocationTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"Address for %@: %@",[[managedObject valueForKey:@"name"] description],[[managedObject valueForKey:@"address"] description]);
    cell.nameLabel.text = [[managedObject valueForKey:@"name"] description];
    CLLocation* location = [[CLLocation alloc] initWithLatitude:[[managedObject valueForKey:@"latitude"] floatValue]  longitude:[[managedObject valueForKey:@"longitude"]floatValue]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Latitude: %@ Longitude:%@",[[managedObject valueForKey:@"latitude"] stringValue],[[managedObject valueForKey:@"longitude"] stringValue]];
    cell.addressLabel.text = [[managedObject valueForKey:@"address"] description];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumFractionDigits:1];
    [formatter setMaximumFractionDigits:2];
    CLLocationDistance distance = [viewController.lastKnownLocation distanceFromLocation:location];
    //converting by 1609.344 because CLLocaitonDistance -(CLLocationDistance) distanceFromLocaiton:(CLLocaiton*)location returns a value for the distance measured in Meters, we want this to 
    //be in miles considering our primary audience would be in the US which uses the English measurement system for distances.
    //
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f miles",distance/1609.344];
    [cell.picture setImage:[UIImage imageWithData:[managedObject valueForKey:@"picture"]]];
    [cell.picture setOpaque:YES];
}
@end
