//
//  ViewController.m
//  testmapkit
//
//  Created by HungNV on 7/30/18.
//  Copyright © 2018 HungNV. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.locationManager = [LocationManager sharedManager];
    [self.locationManager startMonitoringLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
    self.mapView = nil;
}
    
- (void)addAnnotation {
//    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.locationManager.coordinate.latitude, self.locationManager.coordinate.longitude);
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
//    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
//    [self.mapView setRegion:region animated:YES];
}
    
- (IBAction)setMapType:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

- (IBAction)zoomToCurrentLocation:(UIButton *)sender {
    NSLog(@"title:%@", self.mapView.userLocation.title);
    NSLog(@"lat:%f - lng:%f", self.mapView.userLocation.location.coordinate.latitude, self.mapView.userLocation.location.coordinate.longitude);
    
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
}
    
- (IBAction)addAnnotion:(UIButton *)sender {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(self.locationManager.coordinate.latitude, self.locationManager.coordinate.longitude);
    annotation.title = @"My home";
    annotation.subtitle = @"103 Hoang Hoa Tham F.13 Q.Tan Binh HCM";
    [self.mapView addAnnotation:annotation];
    
    [self performSegueWithIdentifier:@"detailSegue" sender:nil];
}
    
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKMapRect mRect = [mapView visibleMapRect];
    MKMapPoint topMapPoint = MKMapPointMake(MKMapRectGetMidX(mRect), MKMapRectGetMinY(mRect));
    MKMapPoint bottomMapPoint = MKMapPointMake(MKMapRectGetMidX(mRect), MKMapRectGetMaxY(mRect));
    
    CLLocationDistance currentDist = MKMetersBetweenMapPoints(topMapPoint, bottomMapPoint);
    CLLocationCoordinate2D mCoordinate = [mapView centerCoordinate];
    
    NSLog(@"lat:%f - lng:%f - dist:%f", mCoordinate.latitude, mCoordinate.longitude, currentDist);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
