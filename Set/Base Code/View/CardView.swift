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
        static let inset: CGFloat = 5
        
        struct Font {
            static let minimumSize: CGFloat = 10
            static let maximumSize: CGFloat = 200
            static let scaleFactor = minimumSize / maximumSize
        }
    }
    
    var body: some View {
        contentView
            .padding(Constant.inset)
            .cardify(isSelected: card.isSelected)
    }
    
    var contentView: some View {
        Text(card.content)
            .aspectRatio(contentMode: .fit)
            .font(.system(size: Constant.Font.maximumSize))
            .minimumScaleFactor(Constant.Font.scaleFactor)
    }
}

#Preview {
    VStack {
        CardView(Card(content: "👑", isSelected: true))
        CardView(Card(content: "👑", isSelected: false))
    }
    .padding()
}
