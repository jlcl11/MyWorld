//
//  MyWorldApp.swift
//  MyWorld
//
//  Created by José Luis Corral on 12/5/24.
//

import SwiftUI
import SwiftData

@main
struct YourAppNameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SwiftDataViewModel())
        }
    }
}
