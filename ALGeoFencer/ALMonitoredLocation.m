//
//  ALMonitoredLocation.m
//  ALGeoFencerV2
//
//  Created by rohandhaimade on 3/6/14.
//  Copyright (c) 2014 apartmentlist. All rights reserved.
//

#import "ALMonitoredLocation.h"

@implementation ALMonitoredLocation

NSString *kMonitoredLocationsKey = @"monitoredLocations";

static NSString * const kLatitudeKey = @"LatitudeKey";
static NSString * const kLongitudeKey = @"LongitudeKey";
static NSString * const kTitleKey = @"TitleKey";
static NSString * const kRadiusKey = @"RadiusKey";

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        // decode the region
        //
        CLLocationDegrees lat = [aDecoder decodeDoubleForKey:kLatitudeKey];
        CLLocationDegrees lon = [aDecoder decodeDoubleForKey:kLongitudeKey];
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(lat, lon);
        self.coordinates = center;
        self.title = [aDecoder decodeObjectForKey:kTitleKey];
        self.radius = [aDecoder decodeIntegerForKey:kRadiusKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    CLLocationDegrees lat = self.coordinates.latitude;
    CLLocationDegrees lon = self.coordinates.longitude;

    [aCoder encodeDouble:lat forKey:kLatitudeKey];
    [aCoder encodeDouble:lon forKey:kLongitudeKey];
    [aCoder encodeObject:self.title forKey:kTitleKey];
    [aCoder encodeInteger:self.radius forKey:kRadiusKey];
}

- (CLCircularRegion *)region {
    return [[CLCircularRegion alloc] initWithCenter:self.coordinates radius:self.radius identifier:self.title];
}

@end
