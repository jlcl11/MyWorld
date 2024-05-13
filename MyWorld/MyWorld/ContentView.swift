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
    
    var body: some View {
        Map(position: $mapViewModel.cameraPosition)
            .onAppear{
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

#Preview {
    ContentView()
}
