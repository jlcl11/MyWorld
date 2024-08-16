//
//  SwiftDataViewModelTests.swift
//  MyWorldTests
//
//  Created by José Luis Corral López on 16/8/24.
//

import XCTest
@testable import MyWorld
import MapKit
import SwiftData

final class SwiftDataViewModelTests: XCTestCase {

    var viewModel: SwiftDataViewModel!
    var modelContext: ModelContext!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = SwiftDataViewModel()
        modelContext = viewModel.modelContext
    }

    override func tearDown() {
        viewModel = nil
        modelContext = nil
        super.tearDown()
    }

    @MainActor func testInsertFavoriteLocation() {
        let favoriteLocation = FavoriteLocation(name: "Test Location", address: "123 Test St", latitude: 37.0, longitude: -121.0)
        viewModel.insertFavoriteLocation(location: favoriteLocation)
        
        XCTAssertTrue(viewModel.favoriteLocations.contains(where: { $0.name == "Test Location" }))
    }

    @MainActor func testDeleteFavoriteLocation() {
        let favoriteLocation = FavoriteLocation(name: "Test Location", address: "123 Test St", latitude: 37.0, longitude: -121.0)
        viewModel.insertFavoriteLocation(location: favoriteLocation)
        viewModel.deleteFavoriteLocation(location: favoriteLocation)
        
        XCTAssertFalse(viewModel.favoriteLocations.contains(where: { $0.name == "Test Location" }))
    }

    @MainActor func testGetFavoriteLocations() {
        viewModel.getFavoriteLocations()
        XCTAssertNotNil(viewModel.favoriteLocations)
    }

    @MainActor func testIsLocationFavorite() {
        let favoriteLocation = FavoriteLocation(name: "Test Location", address: "123 Test St", latitude: 37.0, longitude: -121.0)
        viewModel.insertFavoriteLocation(location: favoriteLocation)

        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.0, longitude: -121.0), addressDictionary: nil))
        mapItem.name = "Test Location"
        
        XCTAssertTrue(viewModel.isLocationFavorite(mapItem))
    }
}
