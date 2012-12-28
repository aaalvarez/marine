//
//  NavigationViewController.m
//  Navigation
//
//  Created by Alejo on 24/12/12.
//  Copyright (c) 2012 Alejo. All rights reserved.
//

#import "NavigationViewController.h"
//#import "NavigationModel.h"

@interface NavigationViewController ()

@property (nonatomic, strong) CLLocationManager *myLocationManager;

@end

@implementation NavigationViewController

@synthesize myLocationManager;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *lastLocation = [locations lastObject];
    NSLog(@"Latitude=%f",lastLocation.coordinate.latitude);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startNavigation:(UIButton *)sender {
    if ([CLLocationManager locationServicesEnabled]) {
        self.myLocationManager = [[CLLocationManager alloc]init];
        
        self.myLocationManager.delegate = self;
        
        [self.myLocationManager startUpdatingLocation];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Location" message:@"Location services disabled. You need to enable them in the settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)stopNavigation:(UIButton *)sender {
    [self.myLocationManager stopUpdatingLocation];
}

@end
