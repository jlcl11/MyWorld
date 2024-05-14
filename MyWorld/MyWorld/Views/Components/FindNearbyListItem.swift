//
//  FindNearbyListItem.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct FindNearbyListItem: View {
    var color: Color
    var imageName: String
    var locationName: String

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundStyle(color.opacity(0.2))
                    .frame(width: 45, height: 45)
                Image(systemName: imageName)
                    .foregroundStyle(color)
            }
            .frame(width: 45)
            .padding(.horizontal, 20)

            Text(locationName)
                .foregroundStyle(.primary)
            Spacer()
        }
        .onTapGesture {
            print("Holis")
        }
    }
}

#Preview {
    FindNearbyListItem(color: .green, imageName: "building.columns", locationName: "Bank")
}
