//
//  Location.h
//  UndergroundMenu
//
//  Created by Doug Mason on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Menu, Restaurant;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSSet *menus;
@property (nonatomic, retain) Restaurant *restaurant;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addMenusObject:(Menu *)value;
- (void)removeMenusObject:(Menu *)value;
- (void)addMenus:(NSSet *)values;
- (void)removeMenus:(NSSet *)values;

@end
