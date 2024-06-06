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
    @Binding var showModalSheet: Bool // Added this line
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var showWebView = false
    @EnvironmentObject var mapViewModel: MapViewModel
    

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
                    withAnimation {
                        show = false
                        mapSelection = nil
                    }
                } label: {
                    Image(systemName: "heart")
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
                
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
            
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    .padding(.bottom)
            } else {
                ContentUnavailableView("No preview available", image: "eye.slash")
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
                    showWebView = true
                }) {
                    Image(systemName: "globe")
                        .frame(width: 75, height: 38)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .sheet(isPresented: $showWebView) {
                    if let url = mapSelection?.url ?? URL(string: "https://www.apple.com/es/") {
                        WebView(url: url)
                    } else {
                        Text("Invalid URL")
                    }
                }
                
                Button(action: {
                    if let phoneNumber = mapSelection?.phoneNumber, let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    } else if let url = URL(string: "tel://911"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    } else {
                        // Handle the error, e.g., show an alert
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
                                showModalSheet = false // Added this line
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
            fetchLookAroundScene()
        }
        .onChange(of: mapSelection) { _ in
            fetchLookAroundScene()
        }
    }
    
    func fetchLookAroundScene() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
}

