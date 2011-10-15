//
//  Food.h
//  UndergroundMenu
//
//  Created by Doug Mason on 8/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Food : NSManagedObject

@property (nonatomic, retain) NSNumber * calories;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSManagedObject *menu;
@property (nonatomic,retain) NSNumber* price;
@end
