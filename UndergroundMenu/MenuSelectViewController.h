//
//  MenuSelectViewController.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class RootViewController;
@class Location;
@interface MenuSelectViewController : UITableViewController<NSFetchedResultsControllerDelegate>
{
    RootViewController* viewController;
    Location* location;
}
@property(nonatomic,retain)RootViewController* viewController;
@property(nonatomic,retain)NSFetchedResultsController* fetchedResultsController;
@property(nonatomic,retain)Location* location;
@end
