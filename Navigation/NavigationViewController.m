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
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end

@implementation NavigationViewController

@synthesize myLocationManager = _myLocationManager;
@synthesize lastLocation = _lastLocation;
@synthesize coordinate = _coordinate;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _lastLocation = [locations lastObject];
    NSLog(@"Latitude=%f",_lastLocation.coordinate.latitude);
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"source controller = %@", [segue sourceViewController]);
    NSLog(@"destination controller = %@", [segue destinationViewController]);
    NSLog(@"identifier = %@", [segue identifier]);
}

- (IBAction)stopNavigation:(UIButton *)sender {
    [self.myLocationManager stopUpdatingLocation];
    NSLog(@"Latitude after stop=%f",_lastLocation.coordinate.latitude);
    _coordinate.latitude = _lastLocation.coordinate.latitude;
    _coordinate.longitude = _lastLocation.coordinate.longitude;
}

@end
