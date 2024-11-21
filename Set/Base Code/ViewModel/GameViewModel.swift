//
//  GameViewModel.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published private var game = Game()
    
    init() {
        createNewGame()
    }

    func createNewGame() {
        game = Game()
    }
    
    var cards: [Card] {
        game.cards
    }
    
    func select(_ card: Card) {
        game.select(card)
    }
}
