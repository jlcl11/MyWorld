//
//  ContentView.swift
//  MyWorld
//
//  Created by José Luis Corral on 12/5/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var mapViewModel = MapViewModel()
    @State private var showModalSheet: Bool = true
    @State var searchText: String = ""

    var body: some View {
        Map(position: $mapViewModel.cameraPosition) {
            UserAnnotation {
                UserAnnotationComponent()
            }

            ForEach(mapViewModel.results, id: \.self) { item in
                let placemark = item.placemark
                Marker(placemark.name ?? "", coordinate: placemark.coordinate)
            }
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        .sheet(isPresented: $showModalSheet, content: {
            DestinationsSheet(searchText: $searchText)
                .presentationDetents([.height(120), .medium, .height(720)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(120)))
                .presentationCornerRadius(40)
                .interactiveDismissDisabled(true)
                .onSubmit(of: .text) {
                    Task { await mapViewModel.searchPlaces(searchText: searchText) }
                }.onChange(of: searchText, {
                    
                    Task { await mapViewModel.searchPlaces(searchText: searchText) }
                })
        })
        .onAppear {
            mapViewModel.checkIfLocationServicesIsEnabled()
        }
    }
}

#Preview {
    ContentView()
}
