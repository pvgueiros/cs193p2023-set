//
//  Stripes.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 25/11/24.
//

import SwiftUI

struct Stripes: Shape {
    let spacing: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var originPoint = CGPoint(x: rect.minX, y: rect.minY)
        
        while originPoint.x < rect.maxX {
            path.move(to: originPoint)
            path.addLine(to: CGPoint(x: originPoint.x, y: rect.maxY))
            
            originPoint.x += spacing
        }
        
        return path
    }
}

#Preview {
    ZStack {
        Squiggle()
            .stroke(lineWidth: 2)
        Stripes(spacing: 10)
            .stroke(lineWidth: 2)
            .clipShape(Squiggle())
    }
    .foregroundStyle(Color.Shape.one)
    .frame(width: 200, height: 100)
}
