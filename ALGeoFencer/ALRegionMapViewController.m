//
//  ALRegionMapViewController.m
//  ALGeoFencerV2
//
//  Created by rohandhaimade on 3/6/14.
//  Copyright (c) 2014 apartmentlist. All rights reserved.
//

#import "ALRegionMapViewController.h"
#import <MBLocationManager.h>
#import <NSSet+BlocksKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ALRegionMapViewController ()

@end

@implementation ALRegionMapViewController

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
    [self.mapView setRegion:MKCoordinateRegionMake(sfCoordinates, MKCoordinateSpanMake(0.1, 0.1))];
    
    self.mapView.delegate = self;
    NSSet *monitoredRegions = [[[MBLocationManager sharedManager] locationManager] monitoredRegions];
    [monitoredRegions bk_each:^(CLCircularRegion *region) {
        MKCircle *monitoredRegionOverlay = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
        [self.mapView addOverlay:monitoredRegionOverlay];
    }];

	// Do any additional setup after loading the view.
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:(MKCircle*)overlay];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        circleView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
        circleView.lineWidth = 2;
        return circleView;
    }

    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
