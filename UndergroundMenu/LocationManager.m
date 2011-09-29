//
//  LocationManager.m
//  UndergroundMenu
//
//  Created by Doug Mason on 9/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

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
