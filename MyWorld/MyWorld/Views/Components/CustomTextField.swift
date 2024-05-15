//
//  CustomTextField.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var searchText: String
    @State private var isRecordingAudio: Bool = false
    @State private var isHoldingButton = false
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding()
                .foregroundStyle(.gray)
            
            if !isRecordingAudio {
                TextField("Search locations here", text: $searchText)
                    .padding(.vertical, 20)
                    .foregroundStyle(.gray)
            } else {
                Spacer()
                WavingBars()
                WavingBars()
                Spacer()
            }
            
            Button{
                isRecordingAudio.toggle()
                
            }label: {
                Image(systemName: isRecordingAudio ? "stop.circle.fill" : "mic")
                    .padding()
                    .tint(.gray)
            }  .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                print("long press")
                isRecordingAudio.toggle()
                
            })
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(50)
    }
}

#Preview {
    CustomTextField(searchText: .constant("Hola"))
}
