//
//  LikedMealItem.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

import SwiftUI

struct LikedMealItem: View {
    var iconName: String
    var locationName: String
    var subtitle: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(8)
                .background(Color.indigo.opacity(0.2))
                .clipShape(Circle())
                .shadow(color: Color.indigo.opacity(0.4), radius: 6, x: 0, y: 3)

            VStack(alignment: .leading, spacing: 2) {
                Text(locationName)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .padding(.horizontal, 4)
        }
        .frame(width: 100, height: 100)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(4)
    }
}


#Preview {
    LikedMealItem(iconName: "house.fill", locationName: "Home", subtitle: "Place to sleep")
}
