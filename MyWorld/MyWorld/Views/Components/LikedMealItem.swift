//
//  LikedMealItem.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct LikedMealItem: View {
    var locationName: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "bookmark.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .padding()
                
                Image(systemName: "bookmark.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray.opacity(0.6))
                    .padding()
                    .offset(x: 3, y: 2)
            }
            
            Text(locationName)
                .font(.headline)
                .bold()
                .offset(y: -20)
            
            Text("Go there")
                .font(.subheadline)
                .offset(y: -20)
        }
        .frame(width: 80, height: 80)
         
        .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LikedMealItem(locationName: "Casita")
}
