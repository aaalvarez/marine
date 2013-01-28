//
//  MyAnnotation.m
//  Navigation
//
//  Created by Alejo on 9/01/13.
//  Copyright (c) 2013 Alejo. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;

- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle {
    self = [super init];
    if (self != nil) {
        _coordinate = paramCoordinates;
        _title = paramTitle;
    }
    return self;
}

@end
