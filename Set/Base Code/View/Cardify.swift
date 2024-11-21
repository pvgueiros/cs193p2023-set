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
        static let borderWidth: CGFloat = 10
        
        struct Shadow {
            static let color: Color = Color.black.opacity(0.5)
            static let radius: CGFloat = 3
            static let x: CGFloat = 2
            static let y: CGFloat = 2
        }
        
        struct DefaultState {
            static let borderWidth: CGFloat = 2
            static let color = Color("Secondary")
        }
        
        struct SelectedState {
            static let borderWidth: CGFloat = 4
            static let color: Color = .blue
        }
    }
    
    private enum CardState {
        case defaultState
        case selected
        
        var borderWidth: CGFloat {
            switch self {
            case .defaultState: return Constant.DefaultState.borderWidth
            case .selected: return Constant.SelectedState.borderWidth
            }
        }
        
        var borderColor: Color {
            switch self {
            case .defaultState: return Constant.DefaultState.color
            case .selected: return Constant.SelectedState.color
            }
        }
    }
    
    // MARK: - Properties
    
    let isSelected: Bool
    private var cardState: CardState {
        isSelected ? .selected : .defaultState
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
                .foregroundStyle(isSelected ? .blue : .gray)
        }
    }
}

extension View {
    func cardify(isSelected: Bool) -> some View {
        modifier(Cardify(isSelected: isSelected))
    }
}
