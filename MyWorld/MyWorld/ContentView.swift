//
//  ContentView.swift
//  MyWorld
//
//  Created by José Luis Corral on 12/5/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var mapViewModel = MapViewModel()
    @State private var showModalSheet: Bool
    @State var searchText: String
    
    init(mapViewModel: MapViewModel = MapViewModel(), showModalSheet: Bool = true, searchText: String = "") {
        self.mapViewModel = mapViewModel
        self.showModalSheet = showModalSheet
        self.searchText = searchText
    }
    
    var body: some View {
        Map(position: $mapViewModel.cameraPosition) {
            UserAnnotation {
                UserAnnotationComponent()
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
        })
        .onAppear {
            mapViewModel.checkIfLocationServicesIsEnabled()
        }
    }
}


#Preview {
    ContentView()
}
