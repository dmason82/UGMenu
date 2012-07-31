//
//  LocationManager.m
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


#import "LocationManager.h"

@implementation LocationManager
@synthesize locMgr,delegate;
BOOL didUpdate = NO;



/**
 Starts updating the Core Location Location Manager with an accuracy of 100 meters.
 */
-(void)startUpdates
{
    NSLog(@"Starting Location updates.\n");
    
    if(locMgr == nil)
    {
        locMgr = [[CLLocationManager alloc] init];
    }
    locMgr.delegate = self;
    
    locMgr.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locMgr startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error 
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[NSString stringWithFormat:@"Error with location %@",[error description]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (didUpdate)
    {
        return;
    }
    didUpdate = YES;
    [locMgr stopUpdatingLocation];
    [delegate newPhysicalLocation:newLocation];
}
@end
