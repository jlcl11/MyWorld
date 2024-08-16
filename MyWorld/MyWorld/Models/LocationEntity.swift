//
//  LocationEntity.swift
//  MyWorld
//
//  Created by José Luis Corral on 19/6/24.
//

import SwiftData
import MapKit

@Model
final class LocationEntity {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String?
    @Attribute(.unique) var address: String?
    @Attribute(.unique) var latitude: Double
    @Attribute(.unique) var longitude: Double
    @Attribute(.unique) var postalCode: String?
    @Attribute(.unique) var country: String?

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(id: UUID = UUID(), name: String? = nil, address: String? = nil, latitude: Double, longitude: Double, postalCode: String? = nil, country: String? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.postalCode = postalCode
        self.country = country
    }
}
