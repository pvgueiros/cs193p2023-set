//
//  CardShapeBuilder.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 21/11/24.
//

import SwiftUI

struct CardShapeBuilder: View {
    
    private struct Constant {
        static let spacingBetweenShapes: CGFloat = 5
        static let shapeAspectRatio: CGFloat = 2/1
        static let borderWidth: CGFloat = 3
    }
    
    let card: Card
    
    var numberOfShapes: Int {
        card.number.rawValue
    }
    
    var shapeColor: Color {
        switch card.color {
        case .orange: .orange
        case .purple: .purple
        case .pink: .pink
        }
    }
    
    var shapeShading: CGFloat {
        switch card.shading {
        case .solid: 1.0
        case .medium: 0.3
        case .open: 0.0
        }
    }
    
    func shapeByAddingStyle(_ shape: some Shape) -> some View {
        shape
            .stroke(lineWidth: Constant.borderWidth)
            .background(shape.fill().opacity(shapeShading))
            .foregroundStyle(shapeColor)
    }
    
    func shape(height: CGFloat) -> some View {
        Group {
            switch card.shape {
            case .diamond:  shapeByAddingStyle(Diamond())
            case .oval:     shapeByAddingStyle(RoundedRectangle(cornerRadius: height / 2))
            case .squiggle: shapeByAddingStyle(Squiggle())
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let shapeHeight = min(
                                (geometry.size.height - 2 * Constant.spacingBetweenShapes) / 3,
                                geometry.size.width / Constant.shapeAspectRatio)
            let shapeWidth = shapeHeight * Constant.shapeAspectRatio
            
            VStack(spacing: Constant.spacingBetweenShapes) {
                ForEach(0..<numberOfShapes, id: \.self) { index in
                    shape(height: shapeHeight)
                        .frame(width: shapeWidth, height: shapeHeight)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    let card = Card(number: .three, shape: .diamond, color: .orange, shading: .medium)
    CardShapeBuilder(card: card)
}
