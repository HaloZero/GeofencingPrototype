//
//  ALMonitoredLocation.h
//  ALGeoFencerV2
//
//  Created by rohandhaimade on 3/6/14.
//  Copyright (c) 2014 apartmentlist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ALMonitoredLocation : NSObject <NSCoding>

extern NSString *kMonitoredLocationsKey;

@property (nonatomic, assign) CLLocationCoordinate2D coordinates;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger radius;

- (CLCircularRegion *)region;



@end
