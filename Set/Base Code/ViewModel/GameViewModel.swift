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
        game.inGameCards
    }
    
    var score: Int {
        game.score
    }
    
    func select(_ card: Card) {
        game.select(card)
    }
    
    func deal() {
        game.deal()
    }
    
    var deckHasCards: Bool {
        !game.deckCards.isEmpty
    }
    
    var cheatButtonEnabled: Bool {
        game.cheatIsAvailable
    }
    
    func cheat() {
        game.cheat()
    }
}
