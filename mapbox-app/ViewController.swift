//
//  ViewController.swift
//  mapbox-app
//
//  Created by Bhavik's Pro 16 on 10/11/24.
//

import UIKit
import MapboxMaps
import CoreLocation

class ViewController: UIViewController {

    // 1. Declare the MapView property
    var mapView: MapView!
    
    // 2. Declare the LocationManager to get the user's current location
    let locationManager = CLLocationManager()
    var pointAnnotationManager: PointAnnotationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. Request location authorization
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // 4. Set up the MapView
        setupMapView()
    }
    
    // 5. Method to set up MapView
    func setupMapView() {
        // Initialize the MapView with the frame size
        mapView = MapView(frame: view.bounds)
        view.addSubview(mapView)
        
        // Create an annotation manager instance
        pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
    }
    
    // 6. Method to update map with user's current location
    func updateLocationOnMap(location: CLLocation) {
        let currentCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        // Move the camera to the current location
        let cameraOptions = CameraOptions(center: currentCoordinate, zoom: 15)
        mapView.camera.ease(to: cameraOptions, duration: 1.5)
        
        // Remove previous annotations if any
        pointAnnotationManager?.annotations.removeAll()
        
        // Create a new annotation
        var pointAnnotation = PointAnnotation(coordinate: currentCoordinate)
        // Set a custom image for the annotation
        if let image = UIImage(named: "asset-location") { // Replace "custom-pin" with your image name
            pointAnnotation.image = .init(image: image, name: "asset-location")
        }
        pointAnnotation.iconAnchor = .bottom
        
        // Add the new annotation
        pointAnnotationManager?.annotations = [pointAnnotation]
    }
}

// 7. CLLocationManagerDelegate methods
extension ViewController: CLLocationManagerDelegate {
    
    // When location is updated, call this method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        updateLocationOnMap(location: newLocation)
    }
    
    // If location authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            // Handle the case when the user denies location permission
            print("Location services are not authorized")
        }
    }
    
    // Handle error in case location update fails
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
