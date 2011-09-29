//
//  LocationsViewController.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class LocationTableViewCell;
@class RootViewController;
@class Restaurant;
@interface LocationsViewController : UITableViewController<NSFetchedResultsControllerDelegate>

{
    Restaurant* restaurant;
    RootViewController* viewController;
}

@property(nonatomic,retain)Restaurant* restaurant;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, retain)RootViewController* viewController;

- (void)configureCell:(LocationTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end
