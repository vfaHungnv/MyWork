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
    self.searchButton.hidden = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    [self addAnnotation];
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
    self.searchButton.hidden = YES;
    [self.mapView setRegion:region animated:YES];
}

- (void)addAnnotation {
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(10.801679, 106.647678);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
    [self.mapView setRegion:region animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    annotation.title = @"My home";
    annotation.subtitle = @"103 Hoang Hoa Tham F.13 Q.Tan Binh HCM";
    [self.mapView addAnnotation:annotation];
    
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.searchButton.hidden = NO;
    NSLog(@"lat:%f - lng:%f", mapView.userLocation.location.coordinate.latitude, mapView.userLocation.location.coordinate.longitude);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
