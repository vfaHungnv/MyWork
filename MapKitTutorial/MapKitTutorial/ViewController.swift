//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by HungNV on 7/31/18.
//  Copyright © 2018 HungNV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 10.783376, longitude: 106.689918)
    let regionRadius: CLLocationDistance = 500
    var artworks: [Artwork] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(artworks)
        
//        centerMapOnLocation(location: initialLocation)
//        let artwork = Artwork(title: "Vitalify ASIA", locationName: "224A - 224B Dien Bien Phu P.7 Q.3 HCM", discripline: "Sortware development", coordinate: CLLocationCoordinate2D(latitude: 10.783376, longitude: 106.689918))
//        mapView.addAnnotation(artwork)
    }
    
    func loadInitialData() {
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        if let data = optionalData {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let object = jsonObject as? [NSString: AnyObject]{
                    if let allDevices = object["data"] as? [[NSString: AnyObject]]{
                        print("Successfull")
                        print(allDevices)
                    }
                }
            } catch {
                print("Error Eccurred")
            }
        }
        
//        guard let data = optionalData else { return }
//        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//
//        let dictionary = json as? [String: Any]
//        let works = dictionary["data"] as? [[Any]]
        
//        let validWorks = works.flatMap { Artwork(json: $0) }
//        artworks.append(contentsOf: validWorks)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else {
            return nil
        }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: 0, y: 0)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let location = view.annotation as? Artwork {
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
            location.mapItem().openInMaps(launchOptions: launchOptions)
        }
    }
}
