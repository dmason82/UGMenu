//
//  RootViewController.h
//  UndergroundMenu
//
//  Created by Doug Mason on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
@class LocationManager;
@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate,CLLocationManagerDelegate,UIActionSheetDelegate>
{
    LocationManager* locManager;
    CLLocation* lastKnownLocation;
}
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) LocationManager* locManager;
@property (nonatomic,retain) CLLocation* lastKnownLocation;
@end
