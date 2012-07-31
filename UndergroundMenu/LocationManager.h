//
//  LocationManager.h
//  UndergroundMenu
//
//  Created by Doug Mason on 9/7/11.
//  Copyright 2011 Doug Mason
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.


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
