//
//  LocationManager.m
//  testmapkit
//
//  Created by HungNV on 7/31/18.
//  Copyright © 2018 HungNV. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
    
+ (id)sharedManager {
    static id sharedMyModel = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
    });
    
    return sharedMyModel;
}

- (void)startMonitoringLocation {
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.activityType = CLActivityTypeFitness;
    _locationManager.distanceFilter = 20;
    [_locationManager requestWhenInUseAuthorization];
    
//    [_locationManager startMonitoringSignificantLocationChanges];
//
//    _locationManager.pausesLocationUpdatesAutomatically = YES;
//    _locationManager.allowsBackgroundLocationUpdates = YES;
    [_locationManager startUpdatingLocation];
}
    
- (void)stopMonitoringLocation {
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    [_locationManager stopUpdatingLocation];
}
    
#pragma mark - CLLocationManager Delegate
    
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"NotDetermined");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            [_locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"AuthorizedWhenInUse");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"AuthorizedAlways");
            break;
        default:
            break;
    }
}
    
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for (CLLocation *location in locations) {
        NSTimeInterval howRecent = [location.timestamp timeIntervalSinceNow];
        if ([location horizontalAccuracy] > 20 && fabs(howRecent) > 10) {
            continue;
        }
        
        self.coordinate = location.coordinate;
        [self stopMonitoringLocation];
    }
}
    @end
