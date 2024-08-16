//
//  MapViewModelTests.swift
//  MyWorldTests
//
//  Created by José Luis Corral López on 16/8/24.
//

import XCTest
import CoreLocation
import MapKit
@testable import MyWorld

class MapViewModelTests: XCTestCase {
    
    var viewModel: MapViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MapViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        XCTAssertNotNil(viewModel.region)
        XCTAssertEqual(viewModel.results.count, 0)
        XCTAssertNil(viewModel.route)
        XCTAssertNil(viewModel.routeDestination)
        XCTAssertFalse(viewModel.routeDisplaying)
        XCTAssertNil(viewModel.lookAroundScene)
    }
    
    func testCheckIfLocationServicesIsEnabled() {
        viewModel.checkIfLocationServicesIsEnabled()
        // This will depend on the actual device's location services. You can mock CLLocationManager for more control in tests.
    }
    
    func testFetchRouteWithNoLocationManager() async {
        await viewModel.fetchRoute(to: MKMapItem())
        XCTAssertNil(viewModel.route)
    }

    func testCancelRoute() {
        viewModel.cancelRoute()
        XCTAssertNil(viewModel.route)
        XCTAssertNil(viewModel.routeDestination)
        XCTAssertFalse(viewModel.routeDisplaying)
    }
    
    func testSearchPlaces() async {
        await viewModel.searchPlaces(searchText: "Restaurant")
        XCTAssertEqual(viewModel.results.count, 0) // Mock search, can test with mock data
    }
}
