//
//  Artwork.swift
//  MapKitTutorial
//
//  Created by HungNV on 7/31/18.
//  Copyright © 2018 HungNV. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discripline: String
    let coordinate: CLLocationCoordinate2D
    
    init?(json: [Any]) {
        self.title = json[16] as? String ?? "No Tittle"
        self.locationName = json[12] as! String
        self.discripline = json[15] as! String
        if let lat = Double(json[18] as! String), let lng = Double(json[19] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    init(title: String, locationName: String, discripline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discripline = discripline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDist = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDist)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
