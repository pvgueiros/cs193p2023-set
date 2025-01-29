//
//  Flip.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 28/01/25.
//

//import SwiftUI
//
//struct Flip: ViewModifier, Animatable {
//    
//    // MARK: - Properties
//    
//    var isFaceUp: Bool {
//        rotationAngle > 90
//    }
//    
//    var rotationAngle: Double
//    var animatableData: Double {
//        get { rotationAngle }
//        set { rotationAngle = newValue }
//    }
//
//    func body(content: Content) -> some View {
//        ZStack {
//            frontView(content: content)
//            backView
//        }
//        .rotation3DEffect(.degrees(rotationAngle), axis: (0, 1, 0))
//    }
//    
//    var baseRectangle: RoundedRectangle {
//        RoundedRectangle(cornerRadius: Constant.cornerRadius)
//    }
//    
//    func frontView(content: Content) -> some View {
//        baseRectangle
//            .strokeBorder(cardState.borderColor ?? defaultColor, lineWidth: cardState.borderWidth)
//            .background(baseRectangle
//                .fill(.white)
//                .shadow(
//                    color: Constant.Shadow.color,
//                    radius: Constant.Shadow.radius,
//                    x: Constant.Shadow.x,
//                    y: Constant.Shadow.y))
//            .overlay(content)
//            .opacity(isFaceUp ? 1 : 0)
//    }
//    
//    var backView: some View {
//        baseRectangle.fill()
//            .foregroundStyle(defaultColor)
//            .shadow(
//                color: Constant.Shadow.color,
//                radius: Constant.Shadow.radius,
//                x: Constant.Shadow.x,
//                y: Constant.Shadow.y)
//            .opacity(isFaceUp ? 0 : 1)
//    }
//}
//
//extension View {
//    func cardify(isFaceUp: Bool, isSelected: Bool, isMatched: Bool?, defaultColor: Color = .black) -> some View {
//        modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, isMatched: isMatched, defaultColor: defaultColor))
//    }
//}
