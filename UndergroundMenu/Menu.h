//
//  Menu.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Food, Location;

@interface Menu : NSManagedObject
@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain)NSDate* dateCreated;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) Location *location;
@end

@interface Menu (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Food *)value;
- (void)removeItemsObject:(Food *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
