//
//  ALAppDelegate.h
//  ALGeoFencerV2
//
//  Created by rohandhaimade on 3/6/14.
//  Copyright (c) 2014 apartmentlist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ALAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

extern const NSString *kMonitoredLocationsKey;

@property (strong, nonatomic) UIWindow *window;
@property (strong, atomic) NSMutableArray *messages;

+ (ALAppDelegate *)instance;

@end
