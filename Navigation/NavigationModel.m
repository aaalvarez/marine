//
//  NavigationModel.m
//  Navigation
//
//  Created by Alejo on 24/12/12.
//  Copyright (c) 2012 Alejo. All rights reserved.
//

#import "NavigationModel.h"

//@interface NavigationModel()

//@property (nonatomic, strong) CLLocationManager *myLocationManager;
//@end
//
@implementation NavigationModel

//@synthesize myLocationManager;
//
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *lastLocation = [locations lastObject];
    NSLog(@"Latitude=%f",lastLocation.coordinate.latitude);
}
//
//
//
@end
