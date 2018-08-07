//
//  LocationManager.h
//  testmapkit
//
//  Created by HungNV on 7/31/18.
//  Copyright © 2018 HungNV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coordinate;
    
+ (id)sharedManager;
- (void)startMonitoringLocation;
- (void)stopMonitoringLocation;
@end
