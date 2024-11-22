//
//  Diamond.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 21/11/24.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
                
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: startPoint)
        
        return path
    }
}
