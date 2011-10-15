//
//  Restaurant.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSData * logo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *locations;
@property (nonatomic, retain) UIColor* bgcolor;
@property (nonatomic, retain) UIColor* txtcolor;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addLocationsObject:(Location *)value;
- (void)removeLocationsObject:(Location *)value;
- (void)addLocations:(NSSet *)values;
- (void)removeLocations:(NSSet *)values;

@end
