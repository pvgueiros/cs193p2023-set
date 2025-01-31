//
//  GameViewModel.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    // MARK: - Initialization
    
    @Published private var game = Game()
    @Published private var leaderboard = LeaderboardManager()
    
    init() {}
    
    // MARK: - Cards
    
    var inGameCards: [Card] {
        game.inGameCards
    }
    
    var deckCards: [Card] {
        game.deckCards
    }
    
    var discardedCards: [Card] {
        game.discardedCards
    }
    
    // MARK: - Scoring
    
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
    
    // MARK: - User Action
    
    func createNewGame() {
        game = Game()
    }

    func select(_ card: Card) {
        game.select(card)
    }
    
    func deal() {
        game.deal()
    }
    
    func cheat() {
        game.cheat()
    }
    
    func shuffleCards() {
        game.shuffleCards()
    }
    
    // MARK: - User Action Helpers
    
    var deckHasCards: Bool {
        !game.deckCards.isEmpty
    }
    
    var cheatButtonEnabled: Bool {
        game.cheatIsAvailable
    }
}
