//
//  NavigationViewController.m
//  Navigation
//
//  Created by Alejo on 24/12/12.
//  Copyright (c) 2012 Alejo. All rights reserved.
//

#import "NavigationViewController.h"
#import "MapViewController.h"
//#import "NavigationModel.h"

@interface NavigationViewController ()

@property (nonatomic, strong) CLLocationManager *myLocationManager;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSMutableArray *points;

@end

@implementation NavigationViewController

@synthesize myLocationManager = _myLocationManager;
@synthesize lastLocation = _lastLocation;
@synthesize coordinate = _coordinate;
@synthesize locations = _locations;
@synthesize points = _points;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _lastLocation = [locations lastObject];
    [_points addObject:[locations lastObject]];
    
    NSLog(@"Latitude=%f",_lastLocation.coordinate.latitude);
    NSLog(@"Longitude=%f",_lastLocation.coordinate.longitude);
    
    NSNumber *latitude = [NSNumber numberWithDouble:_lastLocation.coordinate.latitude];
    NSString *latitudeString = [NSString stringWithFormat:@"%f",[latitude doubleValue]];
    NSNumber *longitude = [NSNumber numberWithDouble:_lastLocation.coordinate.longitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f",[longitude doubleValue]];

    NSArray *coordinate = [NSArray arrayWithObjects:latitudeString, longitudeString, nil];
    [_locations addObject:coordinate];
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
    _locations = [NSMutableArray array];
    _points = [NSMutableArray array];
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
    //NSLog(@"source controller = %@", [segue sourceViewController]);
    //NSLog(@"destination controller = %@", [segue destinationViewController]);
    //NSLog(@"identifier = %@", [segue identifier]);
    MapViewController *map = [segue destinationViewController];
    map.coordinate = _coordinate;
    map.locations = _points;// array with cllocations
}

- (IBAction)stopNavigation:(UIButton *)sender {
    [self.myLocationManager stopUpdatingLocation];
    //NSLog(@"Latitude after stop=%f",_lastLocation.coordinate.latitude);
    //NSLog(@"Longitud after stop=%f",_lastLocation.coordinate.longitude);
    _coordinate.latitude = _lastLocation.coordinate.latitude;
    _coordinate.longitude = _lastLocation.coordinate.longitude;
    //NSLog(@"count objects in locations array: %u", [_locations count]);
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_locations options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jSon string with coordinates: %@", jsonString);
    }
    
    // Send post request to web service
    NSString *urlAsString = @"http://localhost/testNavigation.php";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    //[urlRequest se]
    [urlRequest setHTTPBody:jsonData];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if ([data length] > 0 && error == nil) {
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"html = %@", html);
        }
    }];
}

@end
