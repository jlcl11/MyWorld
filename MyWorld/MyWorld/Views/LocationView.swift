//
//  LocationView.swift
//  MyWorld
//
//  Created by José Luis Corral on 20/5/24.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @Binding var showModalSheet: Bool
    @State private var showWebView = false
    @State private var isHeartFilled = false
    @EnvironmentObject var mapViewModel: MapViewModel
    @Environment(SwiftDataViewModel.self) var swiftDataViewModel
    @State private var scaleEffect: CGFloat = 1.0
    @StateObject var webViewModel = WebViewModel(url: "http://www.google.com")

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(mapSelection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                
                Spacer()
                
                Button {
                    if isHeartFilled {
                        removeFavorite()
                    } else {
                        addFavorite()
                    }
                    isHeartFilled.toggle()
                    scaleEffect = isHeartFilled ? 1.2 : 1.0
                } label: {
                    Image(systemName: isHeartFilled ? "heart.fill" : "heart")
                        .frame(width: 24, height: 24)
                        .foregroundStyle(isHeartFilled ? .indigo : .gray, Color(.systemGray6))
                        .scaleEffect(scaleEffect)
                        .animation(.easeInOut(duration: 0.3), value: scaleEffect)
                }
                .contentTransition(.symbolEffect(.replace))
                
                Button {
                    withAnimation {
                        show = false
                        mapSelection = nil
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            if let lookAroundScene = mapViewModel.lookAroundScene {
                LookAroundPreview(initialScene: lookAroundScene)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .padding(.bottom)
            } else {
                VStack {
                    Image(systemName: "eye.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.gray)
                    Text("No preview available")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            HStack(spacing: 12) {
                Button {
                    if let mapSelection {
                        mapSelection.openInMaps()
                    }
                } label: {
                    Image(systemName: "map")
                        .frame(width: 75, height: 38)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: {
                    if let mapSelection = mapSelection, let url = mapSelection.url {
                        self.webViewModel.changeURL(to: url.absoluteString)
                    } else {
                        self.webViewModel.changeURL(to: "https://www.apple.com/es/")
                    }

                    showWebView = true
                }) {
                    Image(systemName: "globe")
                        .frame(width: 75, height: 38)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .sheet(isPresented: $showWebView) {
                    LoadingView(isShowing: self.$webViewModel.isLoading) {
                        Group {
                            if self.webViewModel.isContentEmpty {
                                VStack {
                                    Spacer()

                                    Image(systemName: "exclamationmark.triangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.indigo)

                                    Text("404")
                                        .font(.system(size: 60))
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)

                                    Text("Page Not Found")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .padding(.top, 8)

                                    Text("Sorry, the page you are trying to open is not available or is empty.")
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.gray)
                                        .padding(.top, 4)
                                        .padding(.horizontal, 24)

                                    Button(action: {
                                        showWebView = false
                                    }) {
                                        Text("Go Back")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(width: 200)
                                            .background(Color.indigo)
                                            .cornerRadius(10)
                                    }
                                    .padding(.top, 20)

                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)   
                            } else {
                                WebView(viewModel: self.webViewModel)
                            }
                        }
                    }
                }
                
                Button(action: {
                    if let phoneNumber = mapSelection?.phoneNumber, let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    } else if let url = URL(string: "tel://911"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    } else {
                        print("Invalid phone number or unable to make a call.")
                    }
                }) {
                    Image(systemName: "phone.badge.waveform")
                        .frame(width: 75, height: 38)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button {
                    Task {
                        if let destination = mapSelection {
                            await mapViewModel.fetchRoute(to: destination)
                            withAnimation {
                                show = false
                                showModalSheet = false
                                NotificationCenter.default.post(name: .init("DYNAMIC_ISLAND"), object: "You are going to \(destination.placemark.name ?? "destination")")
                            }
                        }
                    }
                } label: {
                    Image(systemName: "arrowshape.up")
                        .frame(width: 75, height: 38)
                        .background(.yellow)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .onAppear {
            if let mapSelection = mapSelection {
                mapViewModel.fetchLookAroundScene(for: mapSelection)
            }
            checkIfFavorite()
            addRecent()
        }
        .onChange(of: mapSelection) { newValue in
            if let newValue = newValue {
                mapViewModel.fetchLookAroundScene(for: newValue)
            }
            checkIfFavorite()
            addRecent()
        }
    }
    
    private func checkIfFavorite() {
        if let mapSelection = mapSelection {
            isHeartFilled = swiftDataViewModel.isLocationFavorite(mapSelection)
        }
    }
    
    private func addFavorite() {
        guard let mapSelection = mapSelection else { return }
        let newFavorite = FavoriteLocation(name: mapSelection.placemark.name ?? "",
                                           address: mapSelection.placemark.title ?? "",
                                           latitude: mapSelection.placemark.coordinate.latitude,
                                           longitude: mapSelection.placemark.coordinate.longitude)
        swiftDataViewModel.insertFavoriteLocation(location: newFavorite)
    }

    private func removeFavorite() {
        guard let mapSelection = mapSelection else { return }
        if let favorite = swiftDataViewModel.favoriteLocations.first(where: { $0.name == mapSelection.placemark.name }) {
            swiftDataViewModel.deleteFavoriteLocation(location: favorite)
        }
    }
    
    private func addRecent() {
        guard let mapSelection = mapSelection else { return }
        let newRecent = RecentLocation(name: mapSelection.placemark.name ?? "",
                                       address: mapSelection.placemark.title ?? "",
                                       latitude: mapSelection.placemark.coordinate.latitude,
                                       longitude: mapSelection.placemark.coordinate.longitude)
        swiftDataViewModel.insertRecentLocation(location: newRecent)
    }
}
