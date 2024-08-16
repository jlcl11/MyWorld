//
//  LikedLocation.swift
//  MyWorld
//
//  Created by José Luis Corral on 7/6/24.
//

import Foundation
import SwiftData

@Model
class LikedLocation: Identifiable {
    @Attribute(.unique) let id: UUID
    @Attribute(.unique) var title: String
    var name: String

    init(id: UUID = UUID(), title: String, name: String) {
        self.id = id
        self.title = title
        self.name = name
    }
}

class SwiftDataViewModel: ObservableObject {
    @Published var likedLocations: [LikedLocation] = []
    
    func toggleLocation(_ location: LikedLocation) {
        if let index = likedLocations.firstIndex(where: { $0.title == location.title && $0.name == location.name }) {
            likedLocations.remove(at: index)
        } else {
            likedLocations.append(location)
        }
    }
    
    func isLocationLiked(_ location: LikedLocation) -> Bool {
        return likedLocations.contains(where: { $0.title == location.title && $0.name == location.name })
    }
}

