//
//  MapViewController.m
//  Navigation
//
//  Created by Alejo on 2/01/13.
//  Copyright (c) 2013 Alejo. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize myMapView = _myMapView;
@synthesize coordinate = _coordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.myMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.myMapView.mapType = MKMapTypeStandard;
    self.myMapView.showsUserLocation = YES;    
    self.myMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.myMapView];
    NSLog(@"Latitude in map =%f",_coordinate.latitude);
    NSLog(@"Longitud in map =%f",_coordinate.longitude);
    
    //CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(50.82191692907181, -0.13811767101287842);
    
    MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:_coordinate title:@"title"];
    [self.myMapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
