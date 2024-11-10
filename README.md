# mapbox-app
Integration the Mapbox SDK into an iOS app and displaying the user's current location

# Sample-Token (MapBox)
pk.eyJ1IjoiYmhhdmlrNzI4MCIsImEiOiJjbTNiMDBxMWIxaXZpMnFxeGpzNWpxYTNqIn0.HkHeg0lZceVpIDi4S4HWIA

# Steps to integration and implementation

# Step 1
Open Xcode and create a new project named mapbox-app

# Step 2
Select the App template under iOS. and Choose Swift as the language and UIKit for the user interface.

# Step 3
- Install Mapbox SDK via CocoaPods:
- Navigate to the root directory of your Xcode project in the terminal.
- Create a Podfile (if you don’t have one) by running the following command in the terminal:
bash
- 
pod init

Open the Podfile and add the following line to include Mapbox:
ruby
Copy code

pod 'MapboxMaps', '~> 10.0'

Save the Podfile and run:
bash
pod install

Open the .xcworkspace file to open the project with CocoaPods integration.

#Step 4 - Set up Mapbox:

Sign up at Mapbox and create a new API key.

Go to your Info.plist file and add the following key-value pair to configure Mapbox:
xml

<key>MBXAccessToken</key>
<string>YOUR_MAPBOX_ACCESS_TOKEN</string>

Replace YOUR_MAPBOX_ACCESS_TOKEN with the token you get from Mapbox.

# Step 5 
Create the ViewController to show the map: Create a new ViewController.swift if it's not already present and follow the steps below to implement the functionality:


import UIKit
import MapboxMaps
import CoreLocation

class ViewController: UIViewController {

    // 1. Declare the MapView property
    var mapView: MapView!
    
    // 2. Declare the LocationManager to get the user's current location
    let locationManager = CLLocationManager()
    
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
        let myMapView = MapView(frame: view.bounds)
        self.view.addSubview(myMapView)
        
        // Configure the style and center of the map
        myMapView.mapboxMap.style.uri = .streets
        mapView = myMapView
    }

    // 6. Method to update map with user's current location
    func updateLocationOnMap(location: CLLocation) {
        let currentCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        // Move the camera to the current location
        let cameraOptions = CameraOptions(center: currentCoordinate, zoom: 12)
        mapView.camera.ease(to: cameraOptions, duration: 2)
        
        // Add a marker (point) for the user's location
        let pointAnnotation = PointAnnotation(coordinate: currentCoordinate)
        mapView.annotations.addAnnotation(pointAnnotation)
    }
}

# Step 6 
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



Here is the sample Token
pk.eyJ1IjoiYmhhdmlrNzI4MCIsImEiOiJjbTNiMDBxMWIxaXZpMnFxeGpzNWpxYTNqIn0.HkHeg0lZceVpIDi4S4HWIA
