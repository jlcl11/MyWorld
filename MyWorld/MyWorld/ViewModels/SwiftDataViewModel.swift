//
//  SwiftDataViewModel.swift
//  MyWorld
//
//  Created by José Luis Corral on 7/6/24.
//

import Foundation
import SwiftData
import MapKit

@Observable
final class SwiftDataViewModel: ObservableObject {
    let container = try! ModelContainer(for: FavoriteLocation.self, RecentLocation.self)
    
    @MainActor
    var modelContext: ModelContext {
        container.mainContext
    }
    
    var favoriteLocations: [FavoriteLocation] = []
    var recentLocations: [RecentLocation] = []
    
    @MainActor
    func getFavoriteLocations() {
        let fetchDescriptor = FetchDescriptor<FavoriteLocation>(predicate: nil, sortBy: [SortDescriptor<FavoriteLocation>(\.date)])
        favoriteLocations = try! modelContext.fetch(fetchDescriptor)
    }
    
    @MainActor
    func getRecentLocations() {
        let fetchDescriptor = FetchDescriptor<RecentLocation>(predicate: nil, sortBy: [SortDescriptor<RecentLocation>(\.date)])
        recentLocations = try! modelContext.fetch(fetchDescriptor)
    }
    
    @MainActor
    func insertFavoriteLocation(location: FavoriteLocation) {
        modelContext.insert(location)
        favoriteLocations = []
        getFavoriteLocations()
        
    }
    
    @MainActor
    func deleteFavoriteLocation(location: FavoriteLocation) {
        modelContext.delete(location)
        favoriteLocations = []
        getFavoriteLocations()
    }

    @MainActor
    func insertRecentLocation(location: RecentLocation) {
        modelContext.insert(location)
        recentLocations = []
        getRecentLocations()
    }

    @MainActor
    func isLocationFavorite(_ location: MKMapItem) -> Bool {
        return favoriteLocations.contains(where: { $0.name == location.placemark.name })
    }
}
