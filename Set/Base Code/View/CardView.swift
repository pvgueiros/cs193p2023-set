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
    }
    
    var body: some View {
        CardShapeBuilder(card: card)
            .padding(Constant.cardPadding)
            .cardify(isSelected: card.isSelected, isMatched: card.isMatched)
    }
}

#Preview {
    HStack {
        CardView(Card(number: .one, shape: .two, color: .one, shading: .two))
            .aspectRatio(2/3, contentMode: .fit)
    }
    .padding()
}
