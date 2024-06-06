//
//  DynamicIslandView.swift
//  MyWorld
//
//  Created by José Luis Corral on 6/6/24.
//

import SwiftUI

struct DynamicIslandView: View {
    
    @State var title: String?
    @State var expanded = false
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.up")
                .controlSize(.large)
                .foregroundColor(.accentColor)
                
            
            
            Text(title ?? "")
                .foregroundColor(.white)
        }
        .frame(width: expanded ? UIScreen.main.bounds.width - 22 : 126, height: expanded ? 111 : 37.33)
        .blur(radius: expanded ? 0 : 50)
        .opacity(expanded ? 1 : 0)
        .scaleEffect(expanded ? 1 : 0.5, anchor: .top)
        .background {
            RoundedRectangle(cornerRadius: expanded ? 50 : 63, style: .continuous)
                .fill(.black)
        }
        .onReceive(NotificationCenter.default.publisher(for: .init("DYNAMIC_ISLAND"))) { object in
            
            if let title = object.object as? String {
                self.title = title
            }
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)) {
  
                self.expanded = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)) {
                        
                        self.expanded = false
                        self.title = nil
                    }
                }
            }
        }
        .offset(y: 11)
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    DynamicIslandView(title: "You are going to BBVA")
}
