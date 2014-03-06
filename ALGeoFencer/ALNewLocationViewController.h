//
//  ALNewLocationViewController.h
//  ALGeoFencerV2
//
//  Created by rohandhaimade on 3/6/14.
//  Copyright (c) 2014 apartmentlist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ALMonitoredLocation.h"

@interface ALNewLocationViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextField *radius;

- (IBAction)save;

@end
