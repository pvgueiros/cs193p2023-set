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
        static let spacingBetweenStripes: CGFloat = 6
    }
    
    let card: Card
    
    var numberOfShapes: Int {
        card.number.rawValue
    }
    
    var shapeColor: Color {
        switch card.color {
        case .one: .Shape.one
        case .two: .Shape.two
        case .three: .Shape.three
        }
    }
    
    @ViewBuilder
    func coloredView(_ view: some View) -> some View {
        view.foregroundStyle(shapeColor)
    }
    
    @ViewBuilder
    func shadedViewForShape(_ shape: some Shape) -> some View {
        switch card.shading {
        case .one: shape.fill()
        case .two: shape.stripe(
                            lineWidth: Constant.borderWidth,
                            spacing: Constant.spacingBetweenStripes)
        case .three: shape.stroke(lineWidth: Constant.borderWidth)
        }
    }
     
    @ViewBuilder
    func styledViewForShape(_ shape: some Shape) -> some View {
        coloredView(shadedViewForShape(shape))
    }
    
    @ViewBuilder
    func shapeView(height: CGFloat) -> some View {
        switch card.shape {
        case .one:      styledViewForShape(Diamond())
        case .two:      styledViewForShape(RoundedRectangle(cornerRadius: height / 2))
        case .three:    styledViewForShape(Squiggle())
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
                    shapeView(height: shapeHeight)
                        .frame(width: shapeWidth, height: shapeHeight)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    let card = Card(number: .three, shape: .three, color: .three, shading: .two)
    CardShapeBuilder(card: card)
        .frame(width: 200, height: 600)
}
