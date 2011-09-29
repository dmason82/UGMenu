//
//  MenuViewController.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootViewController;
@class Menu;
@class FoodTableViewCell;
@interface MenuViewController : UITableViewController<NSFetchedResultsControllerDelegate>
{
    RootViewController* viewController;
    NSManagedObject* menu;
    NSArray* foodItems;
    NSManagedObjectContext* managedObjectContext;
}
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic,retain)RootViewController* viewController;
@property(nonatomic,retain)NSArray* foodItems;
@property(nonatomic,retain)NSManagedObject* menu;
-(void)configureCell:(FoodTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end
