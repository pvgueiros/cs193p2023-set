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

    func createNewGame() {
        game = Game()
    }
    
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

    func select(_ card: Card) {
        game.select(card)
    }
    
    var deckHasCards: Bool {
        !game.deckCards.isEmpty
    }
    
    func flipTopDeckCard() {
        game.flipTopDeckCard()
    }
    
    func deal() {
//        game.deal()
        game.dealSingleCard()
    }
    
    var cheatButtonEnabled: Bool {
        game.cheatIsAvailable
    }
    
    func cheat() {
        game.cheat()
    }
    
    func shuffleCards() {
        game.shuffleCards()
    }
}
