//
//  DestinationsSheet.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI
import SwiftData

struct DestinationsSheet: View {
    @Binding var searchText: String
    @State private var initialNearbyItems: [FindNearbyListItem] = [
        FindNearbyListItem(color: .red, imageName: "fuelpump", locationName: "Gas Stations"),
        FindNearbyListItem(color: .green, imageName: "fork.knife", locationName: "Restaurants"),
        FindNearbyListItem(color: .yellow, imageName: "building.columns", locationName: "Banks & ATMS")
    ]
    @Query private var favoriteLocations: [FavoriteLocation]
    
    @State private var recentHistoryItems: [RecentLocationItem] = [
        RecentLocationItem(name: "Kendom", adress: "Mojo Dojo Casa House, BarbieLand"),
        RecentLocationItem(name: "Kendom", adress: "Mojo Dojo Casa House, BarbieLand"),
        RecentLocationItem(name: "Kendom", adress: "Mojo Dojo Casa House, BarbieLand")
    ]
    
    @State private var showFindMoreButton: Bool = true

    var body: some View {
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


                ScrollView(.horizontal) {
                    HStack {
                        ForEach(favoriteLocations) { location in
                            LikedMealItem(iconName: "heart.fill", locationName: location.name, subtitle: location.address)
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
                            .onTapGesture {
                                searchText = item.locationName
                            }
                        Divider()
                    }
                }

                if showFindMoreButton {
                    VStack(alignment: .leading) {
                        Button {
                            withAnimation {
                                initialNearbyItems.append(contentsOf: [
                                    FindNearbyListItem(color: .blue, imageName: "p.circle", locationName: "Parkings"),
                                    FindNearbyListItem(color: .mint, imageName: "cart.fill", locationName: "Supermarket"),
                                    FindNearbyListItem(color: .gray, imageName: "h.circle.fill", locationName: "Hotels"),
                                    FindNearbyListItem(color: .orange, imageName: "bag.fill", locationName: "Shopping"),
                                    FindNearbyListItem(color: .purple, imageName: "dumbbell.fill", locationName: "Gyms"),
                                    FindNearbyListItem(color: .pink, imageName: "bicycle", locationName: "Bike Rentals"),
                                    FindNearbyListItem(color: .teal, imageName: "leaf.fill", locationName: "Parks"),
                                    FindNearbyListItem(color: .indigo, imageName: "tram.fill", locationName: "Public Transport")
                                ])
                                showFindMoreButton = false
                            }
                        } label: {
                            Text("Find more")
                                .underline()
                        }
                    }
                    .padding()
                }

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
