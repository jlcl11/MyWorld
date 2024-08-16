//
//  Untitled.swift
//  MyWorld
//
//  Created by José Luis Corral López on 14/8/24.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true
    @Published var isContentEmpty: Bool = false   

    init(url: String) {
        self.url = url
    }

    func changeURL(to newURL: String) {
        self.url = newURL
        self.isLoading = true
        self.isContentEmpty = false
    }
}
