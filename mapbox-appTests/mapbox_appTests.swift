//
//  mapbox_appTests.swift
//  mapbox-appTests
//
//  Created by Bhavik's Pro 16 on 10/11/24.
//

import XCTest
import MapboxMaps
import CoreLocation
@testable import mapbox_app


final class mapbox_appTests: XCTestCase {
    
    var mapView: MapView!
    var locationManager: CLLocationManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mapView = MapView(frame: UIScreen.main.bounds)
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func setUp() {
        super.setUp()
        locationManager = CLLocationManager()
    }
    
    func testLocationPermission() {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            XCTAssertTrue(true, "Location permission granted")
        } else {
            XCTAssertTrue(false, "Location permission denied")
        }
    }
}
