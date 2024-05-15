//
//  DestinationsSheet.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct DestinationsSheet: View {
    @Binding var searchText: String

    var body: some View {
        var initialNearbyItems: [FindNearbyListItem] = [
            FindNearbyListItem(color: .red, imageName: "fuelpump", locationName: "Gas Stations"),
            FindNearbyListItem(color: .green, imageName: "fork.knife", locationName: "Restaurants"),
            FindNearbyListItem(color: .yellow, imageName: "building.columns", locationName: "Banks & ATMS")
        ]

        var recentHistoryItems: [RecentLocationItem] = [
            RecentLocationItem(name: "Kendom", adress: "Mojo Dojo Casa House, BarbieLand"),
            RecentLocationItem(name: "Kendom", adress: "Mojo Dojo Casa House, BarbieLand"),
            RecentLocationItem(name: "Kendom", adress: "Mojo Dojo Casa House, BarbieLand")
        ]

        ScrollView {
            VStack {
                HStack {
                    Text("Where do you want to go?")
                        .font(.title2)
                        .padding(.vertical, 10)
                        .bold()
                    Spacer()
                }

                CustomTextField(searchText: $searchText)
                    .padding(.bottom, 10)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(1..<100) { n in
                            LikedMealItem(iconName: "heart.fill", locationName: "\(n)", subtitle: "Go there")
                        }
                    }
                }
                .padding(.vertical)

                Section(header: HStack {
                    Text("Find Nearby").font(.footnote).foregroundStyle(.gray).bold()
                    Spacer()
                }.padding(.bottom, 5)) {
                    ForEach(initialNearbyItems, id: \.locationName) { item in
                        FindNearbyListItem(color: item.color, imageName: item.imageName, locationName: item.locationName)
                        Divider()
                    }
                }

                VStack(alignment: .leading) {
                    Button {
                    } label: {
                        Text("Find more")
                            .underline()
                    }
                }
                .padding()

                Section(header: HStack {
                    Text("Recent").font(.footnote).foregroundStyle(.gray).bold()
                    Spacer()
                }.padding(.vertical, 5)) {
                    ForEach(recentHistoryItems, id: \.name) { item in
                        RecentLocationItem(name: item.name, adress: item.adress)
                        Divider()
                    }
                }

                VStack(alignment: .leading) {
                    Button {
                    } label: {
                        Text("Show the whole history")
                            .underline()
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    DestinationsSheet(searchText: .constant(""))
}
