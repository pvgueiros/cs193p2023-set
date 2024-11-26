//
//  Cardify.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 19/11/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    // MARK: - Constants
    
    private struct Constant {
        static let cornerRadius: CGFloat = 10
        
        struct Shadow {
            static let color: Color = Color.black.opacity(0.5)
            static let radius: CGFloat = 3
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
        
        var borderColor: Color {
            switch self {
                
            case .defaultState: return Color.Base.primary
            case .selected: return Color.Feedback.selected
            case .success: return Color.Feedback.success
            case .error: return Color.Feedback.error
            }
        }
    }
    
    var isSelected: Bool
    var isMatched: Bool?
    
    var cardState: CardState {
        isSelected ?
            (isMatched == nil ?
                .selected :
                (isMatched! ?
                    .success :
                    .error)):
            .defaultState
    }

    func body(content: Content) -> some View {
        let baseRectangle = RoundedRectangle(cornerRadius: Constant.cornerRadius)
        
        ZStack {
            baseRectangle
                .strokeBorder(cardState.borderColor, lineWidth: cardState.borderWidth)
                .background(baseRectangle
                    .fill(.white)
                    .shadow(
                        color: Constant.Shadow.color,
                        radius: Constant.Shadow.radius,
                        x: Constant.Shadow.x,
                        y: Constant.Shadow.y))
                .overlay(content)
        }
    }
}

extension View {
    func cardify(isSelected: Bool, isMatched: Bool?) -> some View {
        modifier(Cardify(isSelected: isSelected, isMatched: isMatched))
    }
}
