//
//  ViewController.h
//  testmapkit
//
//  Created by HungNV on 7/30/18.
//  Copyright © 2018 HungNV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *currentLcationButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)setMapType:(UISegmentedControl *)sender;
- (IBAction)zoomToCurrentLocation:(UIButton *)sender;

@end

