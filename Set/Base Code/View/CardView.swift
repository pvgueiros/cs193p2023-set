//
//  CardView.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 18/11/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constant {
        static let cardPadding: CGFloat = 15
        
        struct Animation {
            static let defaultScale: CGFloat = 1.0
            static let matchedScale: CGFloat = 1.2
            static let mismatchScale: CGFloat = 0.8
        }
        
    }
    
    @State private var cardViewScale: CGFloat = Constant.Animation.defaultScale
    
    var body: some View {
        CardShapeBuilder(card: card)
            .padding(Constant.cardPadding)
            .cardify(
                isFaceUp: card.isFaceUp,
                isSelected: card.isSelected,
                isMatched: card.isMatched,
                defaultColor: Color.Base.primary
            )
            .scaleEffect(cardViewScale)
            .onChange(of: card.isMatched) { _, isMatched in
                animateCardScale(cardIsMatched: isMatched)
            }
    }
    
    private func animateCardScale(cardIsMatched: Bool?) {
        guard let cardIsMatched else { return }
        
        withAnimation(.smooth) {
            cardViewScale = cardIsMatched
                ? Constant.Animation.matchedScale
                : Constant.Animation.mismatchScale
        } completion: {
            withAnimation(.smooth) {
                cardViewScale = Constant.Animation.defaultScale
            }
        }
    }
}

#Preview {
    HStack {
        CardView(Card(number: .one, shape: .two, color: .one, shading: .two, isFaceUp: true))
            .aspectRatio(2/3, contentMode: .fit)
    }
    .padding()
}
