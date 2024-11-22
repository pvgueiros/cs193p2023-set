//
//  GameViewModel.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published private var game = Game()
    
    init() {}

    func createNewGame() {
        game = Game()
    }
    
    var cards: [Card] {
        game.visibleCards
    }
    
    var score: Int {
        return 0
    }
    
    func select(_ card: Card) {
        game.select(card)
    }
    
    func deal() {
        game.deal()
    }
}
