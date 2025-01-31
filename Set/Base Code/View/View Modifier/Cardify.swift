//
//  Cardify.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 19/11/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    // MARK: - Constants
    
    private struct Constant {
        static let cornerRadius: CGFloat = 10
        
        struct Shadow {
            static let color: Color = Color.black.opacity(0.2)
            static let radius: CGFloat = 1
            static let x: CGFloat = 2
            static let y: CGFloat = 2
        }
    }
    
    enum CardState {
        case defaultState
        case selected
        case success
        case error
        
        var borderWidth: CGFloat {
            switch self {
                
            case .defaultState: return 2
            default: return 4
            }
        }
        
        var borderColor: Color? {
            switch self {
                
            case .defaultState: return nil
            case .selected: return Color.Feedback.selected
            case .success: return Color.Feedback.success
            case .error: return Color.Feedback.error
            }
        }
    }
    
    // MARK: - Properties
    
    var isFaceUp: Bool {
        rotationAngle > 90
    }
    var isSelected: Bool
    var isMatched: Bool?
    let defaultColor: Color
    
    var rotationAngle: Double
    var animatableData: Double {
        get { rotationAngle }
        set { rotationAngle = newValue }
    }
    
    var cardState: CardState {
        isSelected ?
            (isMatched == nil ?
                .selected :
                (isMatched! ?
                    .success :
                    .error)):
            .defaultState
    }
    
    init(isFaceUp: Bool, isSelected: Bool, isMatched: Bool?, defaultColor: Color = .black) {
        self.isSelected = isSelected
        self.isMatched = isMatched
        self.defaultColor = defaultColor
        self.rotationAngle = isFaceUp ? 180 : 0
    }

    func body(content: Content) -> some View {
        ZStack {
            frontView(content: content)
            backView
        }
        .rotation3DEffect(.degrees(rotationAngle), axis: (0, 1, 0))
    }
    
    var baseRectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: Constant.cornerRadius)
    }
    
    func frontView(content: Content) -> some View {
        baseRectangle
            .strokeBorder(cardState.borderColor ?? defaultColor, lineWidth: cardState.borderWidth)
            .background(baseRectangle
                .fill(.white)
                .shadow(
                    color: Constant.Shadow.color,
                    radius: Constant.Shadow.radius,
                    x: -Constant.Shadow.x,
                    y: Constant.Shadow.y))
            .overlay(content)
            .opacity(isFaceUp ? 1 : 0)
    }
    
    var backView: some View {
        baseRectangle.fill()
            .foregroundStyle(defaultColor)
            .shadow(
                color: Constant.Shadow.color,
                radius: Constant.Shadow.radius,
                x: Constant.Shadow.x,
                y: Constant.Shadow.y)
            .opacity(isFaceUp ? 0 : 1)
    }
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, isMatched: Bool?, defaultColor: Color = .black) -> some View {
        modifier(
            Cardify(isFaceUp: isFaceUp, isSelected: isSelected, isMatched: isMatched, defaultColor: defaultColor)
                .animation(nil))
    }
}
