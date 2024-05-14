//
//  CustomTextField.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding()
                .foregroundStyle(.gray)
            
            TextField("Search locations here", text: $searchText)
                .padding(.vertical, 20)
                .foregroundStyle(.gray)
            
            Button{
                
            }label: {
                Image(systemName: "mic")
                    .padding()
                    .tint(.gray)
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(50)
    }
}

#Preview {
    CustomTextField(searchText: .constant("Hola"))
}
