//
//  MapViewModel.swift
//  MyWorld
//
//  Created by José Luis Corral on 13/5/24.
//

import SwiftUI
import MapKit
import Combine

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054),
                                               span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var results = [MKMapItem]()
    @Published var route: MKRoute?
    @Published var routeDestination: MKMapItem?
    @Published var routeDisplaying = false
    @Published var lookAroundScene: MKLookAroundScene?

    var locationManager: CLLocationManager?

    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager?.delegate = self
                    self.locationManager?.requestWhenInUseAuthorization()
                }
            } else {
                DispatchQueue.main.async {
                    print("Show an alert")
                }
            }
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("We need your location")
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locationManager.location {
                DispatchQueue.main.async {
                    self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                }
            }
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }

    func searchPlaces(searchText: String) async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region

        let searchResults = try? await MKLocalSearch(request: request).start()
        DispatchQueue.main.async {
            self.results = searchResults?.mapItems ?? []
        }
    }

    func fetchRoute(to destination: MKMapItem) async {
        guard let userLocation = locationManager?.location else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: userLocation.coordinate))
        request.destination = destination
        request.transportType = .walking

        let directions = MKDirections(request: request)
        let result = try? await directions.calculate()
        DispatchQueue.main.async {
            self.route = result?.routes.first
            self.routeDestination = destination

            if let rect = self.route?.polyline.boundingMapRect {
                withAnimation(.snappy) {
                    self.cameraPosition = .rect(rect)
                    self.routeDisplaying = true
                }
            }
        }
    }

    func cancelRoute() {
        DispatchQueue.main.async {
            self.route = nil
            self.routeDestination = nil
            self.routeDisplaying = false
        }
    }

    func updateCameraAndFetchInfo(for mapItem: MKMapItem, mapSelection: Binding<MKMapItem?>, showLocationSheet: Binding<Bool>) async {
        // Update camera position
        let coordinate = mapItem.placemark.coordinate
        DispatchQueue.main.async {
            withAnimation {
                self.cameraPosition = .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                ))
            }
        }

        // Fetch detailed information
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = mapItem.name
        request.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        do {
            let response = try await MKLocalSearch(request: request).start()
            if let updatedMapItem = response.mapItems.first {
                DispatchQueue.main.async {
                    mapSelection.wrappedValue = updatedMapItem
                    showLocationSheet.wrappedValue = true
                    
                    self.results = [updatedMapItem]
                }
            }
        } catch {
            print("Failed to fetch detailed information: \(error)")
        }
    }

    func fetchLookAroundScene(for mapItem: MKMapItem) {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: mapItem)
            let scene = try? await request.scene
            DispatchQueue.main.async {
                self.lookAroundScene = scene
            }
        }
    }
}
