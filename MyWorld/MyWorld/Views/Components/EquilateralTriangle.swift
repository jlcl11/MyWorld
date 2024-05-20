//
//  EquilateralTriangle.swift
//  MyWorld
//
//  Created by José Luis Corral on 14/5/24.
//

import SwiftUI

struct EquilateralTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let sideLength = min(rect.width, rect.height)
        let height = sideLength * sqrt(3) / 2
        
        let startX = rect.midX
        let startY = rect.midY - (height / 2)
        
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX - (sideLength / 2), y: startY + height))
        path.addLine(to: CGPoint(x: startX + (sideLength / 2), y: startY + height))  
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    EquilateralTriangle()
}
