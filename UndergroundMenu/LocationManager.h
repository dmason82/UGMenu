//
//  LocationManager.h
//  UndergroundMenu
//
//  Created by Doug Mason on 9/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol LocationGetterDelegate
@required
-(void)newPhysicalLocation:(CLLocation*)location;
@end


@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager* locMgr;
    id delegate;
}
@property(nonatomic,retain) CLLocationManager *locMgr;
@property(nonatomic,retain) id delegate;

-(void)startUpdates;
@end
