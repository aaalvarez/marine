//
//  MapViewController.h
//  Navigation
//
//  Created by Alejo on 2/01/13.
//  Copyright (c) 2013 Alejo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CSMapRouteLayerView.h"

@interface MapViewController : UIViewController

@property (nonatomic, strong) MKMapView *myMapView;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) CSMapRouteLayerView* routeView;

@end
