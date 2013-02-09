//
//  CSMapRouteLayerView.h
//  Marine
//
//  Created by Alejo on 5/02/13.
//  Copyright (c) 2013 Alejo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CSMapRouteLayerView : UIView
{
    MKMapView* _mapView;
    NSArray* _points;
    UIColor* _lineColor;
}

-(id) initWithRoute:(NSArray*)routePoints mapView:(MKMapView*)mapView;

@property (nonatomic, retain) NSArray* points;
@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) UIColor* lineColor;

@end