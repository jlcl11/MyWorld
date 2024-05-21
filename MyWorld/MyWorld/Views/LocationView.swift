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
    @State private var lookAroundScene: MKLookAroundScene?
    
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
                    show = false
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
                
            }
            
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
            } else {
                ContentUnavailableView("No preview available", image: "eye.slash")
            }
        }
        .onAppear {
            fetchLookAroundScene()
        } .onChange(of: mapSelection, {
            fetchLookAroundScene()
        })
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

#Preview {
    LocationView(mapSelection: .constant(nil), show: .constant(true))
}
