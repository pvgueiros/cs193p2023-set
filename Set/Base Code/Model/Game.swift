//
//  Game.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import Foundation

struct Game {
    private(set) var cards: [Card]
    
    init() {
        let content = ["👑", "🧣", "👚", "🩳", "🧦", "🧢", "👗", "👖", "🩱", "👔", "🧤", "🧥"]
        self.cards = content.map { Card(content: $0, isSelected: false)}
    }
    
    mutating func select(_ card: Card) {
        if let index = cards.firstIndex(of: card) {
            cards[index].toggleSelected()
        }
    }
}

struct Card: Identifiable, Equatable {
    let id = UUID()
    let content: String
    var isSelected: Bool
    
    mutating func toggleSelected() {
        isSelected.toggle()
    }
}
 
