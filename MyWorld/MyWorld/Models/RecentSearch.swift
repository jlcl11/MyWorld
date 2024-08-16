//
//  RecentSearch.swift
//  MyWorld
//
//  Created by José Luis Corral on 21/6/24.
//

import Foundation
import SwiftData

@Model
class RecentSearch: Identifiable {
    @Attribute(.unique) var id: UUID
    var searchText: String
    var date: Date

    init(searchText: String, date: Date = Date()) {
        self.id = UUID()
        self.searchText = searchText
        self.date = date
    }
}
