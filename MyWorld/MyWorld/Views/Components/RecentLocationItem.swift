//
//  RecentLocationItem.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct RecentLocationItem: View {
    var likedLocation: RecentLocation
    var body: some View {
        
      
            HStack {
             
                Image(systemName: "arrow.counterclockwise")
                    .foregroundStyle(.primary)
                    .frame(width: 15)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading){
                    Text(likedLocation.name)
                        .foregroundStyle(.primary)
                        .font(.headline)
                    
                    Text(likedLocation.address)
                        .foregroundStyle(.primary)
                        .font(.subheadline)
                }
                Spacer()
            }
        }

    }
 
