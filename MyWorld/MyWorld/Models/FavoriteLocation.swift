//
//  FavoriteLocation.swift
//  MyWorld
//
//  Created by José Luis Corral on 20/6/24.
//

import Foundation
import SwiftData
 
@Model
final class FavoriteLocation {
    @Attribute(.unique) var id: UUID
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var date: Date

    init(name: String, address: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.date = Date()
    }
}

