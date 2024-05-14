//
//  RecentLocationItem.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct RecentLocationItem: View {
    var name: String
    var adress: String
    var body: some View {
        
      
            HStack {
             
                Image(systemName: "arrow.counterclockwise")
                    .foregroundStyle(.primary)
                    .frame(width: 15)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading){
                    Text(name)
                        .foregroundStyle(.primary)
                        .font(.headline)
                    
                    Text(adress)
                        .foregroundStyle(.primary)
                        .font(.subheadline)
                }
                Spacer()
            }.onTapGesture {
                print("Holiwis")
            }
        }

    }


#Preview {
    RecentLocationItem(name: "Casa", adress: "Mojo Dojo Casa House, BarbieLand")
}
