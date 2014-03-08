//
//  ALAppDelegate.m
//  ALGeoFencerV2
//
//  Created by rohandhaimade on 3/6/14.
//  Copyright (c) 2014 apartmentlist. All rights reserved.
//

#import "ALAppDelegate.h"
#import "ALMonitoredLocation.h"
#import <MBLocationManager.h>
#import <NSArray+BlocksKit.h>
#import <MapKit/MapKit.h>

@implementation ALAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.


    [self debugMessage:[NSString stringWithFormat:@"Started app at %@", [NSDate new]]];

    [[NSUserDefaults standardUserDefaults] registerDefaults:@{kMonitoredLocationsKey: @[]}];

    [[MBLocationManager sharedManager] startLocationUpdates:kMBLocationManagerModeStandard
                                             distanceFilter:kCLDistanceFilterNone
                                                   accuracy:kCLLocationAccuracyBest];

    NSArray *locationsWithData = [[NSUserDefaults standardUserDefaults] objectForKey:kMonitoredLocationsKey];
    NSArray *objects = [locationsWithData bk_map:^id(id obj) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    }];

    [MBLocationManager sharedManager].locationManager.delegate = self;
    [objects bk_each:^(ALMonitoredLocation *location) {
        [[[MBLocationManager sharedManager] locationManager] startMonitoringForRegion:location.region];
    }];

    return YES;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self debugMessage:[NSString stringWithFormat:@"General error: %@", [error localizedDescription]]];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    [self debugMessage:[NSString stringWithFormat:@"Failed Region %@", [error localizedDescription]]];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self debugMessage:[NSString stringWithFormat:@"Entering Location %@", region]];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self debugMessage:[NSString stringWithFormat:@"Entering Location %@", region]];
}

- (void)debugMessage:(NSString *)message {
    if(!self.messages) {
        self.messages = [NSMutableArray array];
    }
    [self.messages addObject:message];
    NSLog(@"%@", message);
}


+ (ALAppDelegate *)instance {
    return (ALAppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self debugMessage:[NSString stringWithFormat:@"App resign active background at %@", [NSDate new]]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self debugMessage:[NSString stringWithFormat:@"App entered background at %@", [NSDate new]]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        [self debugMessage:[NSString stringWithFormat:@"App entered foreground at %@", [NSDate new]]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self debugMessage:[NSString stringWithFormat:@"App entered active at %@", [NSDate new]]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self debugMessage:[NSString stringWithFormat:@"App entered terminated at %@", [NSDate new]]];
}

@end
