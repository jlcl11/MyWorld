//
//  LikedMealItem.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct LikedMealItem: View {
    var iconName: String
    var locationName: String
    var subtitle: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.vertical, 4)
            Text(locationName)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 80, height: 80)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(4)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary, lineWidth: 1)
        )
    }
}


#Preview {
    LikedMealItem(iconName: "house.fill", locationName: "Home", subtitle: "Place to sleep")
}
