//
//  MapViewController.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 02.08.2022.
//

import UIKit
import MapKit
class MapViewController: UIViewController {

    var place: Place!
    
    
    
    @IBOutlet var mapView: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlacemark()
    }
    
    
    private func setupPlacemark() {
        guard let location = place.location else { return }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    
    
    
    
    
    @IBAction func closeVC() {
        dismiss(animated: true)
    }

    
}
