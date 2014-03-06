//
//  ALNewLocationViewController.m
//  ALGeoFencerV2
//
//  Created by rohandhaimade on 3/6/14.
//  Copyright (c) 2014 apartmentlist. All rights reserved.
//

#import "ALNewLocationViewController.h"
#import <MBLocationManager.h>

@interface ALNewLocationViewController ()

@end

@implementation ALNewLocationViewController

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

    CLLocationCoordinate2D sfCoordinates = CLLocationCoordinate2DMake(37.780650, -122.395500);

    self.mapView.delegate = self;
    [self.mapView setRegion:MKCoordinateRegionMake(sfCoordinates, MKCoordinateSpanMake(0.05, 0.05))];

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = sfCoordinates;
    annotation.title = @"Location";

    [self.mapView addAnnotation:annotation];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save {
    NSString *title = self.titleInput.text;
    MKPointAnnotation *pinLocation = [self.mapView.annotations lastObject];
    if (!title) {
        title = [NSString stringWithFormat:@"Location %@ %@", @(pinLocation.coordinate.latitude), @(pinLocation.coordinate.longitude)];
    }

    NSInteger radius = [self.radius.text integerValue];
    if (!radius || radius == 0) {
        radius = 100;
    }

    ALMonitoredLocation *monitoredLocation = [ALMonitoredLocation new];
    monitoredLocation.radius = radius;
    monitoredLocation.coordinates = pinLocation.coordinate;
    monitoredLocation.title = title;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *monitoredLocations = [[defaults objectForKey:kMonitoredLocationsKey] mutableCopy];
    
    [monitoredLocations addObject:[NSKeyedArchiver archivedDataWithRootObject:monitoredLocation]];

    [defaults setObject:monitoredLocations forKey:kMonitoredLocationsKey];
    [defaults synchronize];

    [[[MBLocationManager sharedManager] locationManager] startMonitoringForRegion:monitoredLocation.region];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

    static NSString *reuseId = @"pin";
    MKPinAnnotationView *pav = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pav == nil)
    {
        pav = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        pav.draggable = YES;
        pav.canShowCallout = YES;
    }
    else
    {
        pav.annotation = annotation;
    }

    return pav;
}

@end
