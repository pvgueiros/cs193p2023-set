//
//  GameViewModel.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published private var game = Game()
    @Published private var leaderboard = LeaderboardManager()
    
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
    
    var finalScore: Int? {
        if let finalScore = game.finalScore {
            leaderboard.addEntry(score: finalScore, name: "Popó")
        }
        return game.finalScore
    }
    
    var highScore: String {
        String(max(leaderboard.highScore ?? 0, finalScore ?? 0))
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
