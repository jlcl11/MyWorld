//
//  UserAnnotationComponent.swift
//  MyWorld
//
//  Created by José Luis Corral on 13/5/24.
//

import SwiftUI

struct UserAnnotationComponent: View {
    var body: some View {
        ZStack {
            
            EquilateralTriangle()
                     .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.indigo]), startPoint: .bottom, endPoint: .top))
                     .offset(y: 10)
                     .frame(width: 45, height: 45)
                     .rotationEffect(.degrees(180))
            	
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.indigo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 30, height: 30)
            
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.indigo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 25, height: 25)
            
            Image(systemName: "figure.wave")
                .foregroundStyle(.indigo)
            
            Text("You")
                .fontDesign(.monospaced)
                .fontWeight(.semibold)
                .font(.caption2)
                .offset(y: 22)
        }
    }
}

#Preview {
    UserAnnotationComponent()
}
