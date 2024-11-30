//
//  Game.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import Foundation

struct Game {
    
    // MARK: - Constants
    
    private struct Constant {
        static let initialNumberOfCardsOnDeck: Int = 12
        static let numberOfCardsPerDeal = 3
        
        struct Score {
            static let initialScore: Int = 0
            
            static let matchSuccess: Int = 3
            static let allCardsMatched: Int = 100
            
            static let matchError: Int = -1
            static let dealtWithAvailableSet: Int = -2
            static let cheated: Int = -3
            
            static let timeBonusMultiplier: Double = 3 // maximum matchSuccess multiplier
            static let timeBonusInterval: TimeInterval = 15 // maximum match time to get time bonus
        }
    }
    
    static private let cards: [Card] = createAllCards()
    static private func createAllCards() -> [Card] {
        var cards = [Card]()
        
        for number in Ternary.allCases {
            for shape in Ternary.allCases {
                for color in Ternary.allCases {
                    for shading in Ternary.allCases {
                        let card = Card(number: number, shape: shape, color: color, shading: shading)
                        cards.append(card)
                    }
                }
            }
        }
        return cards
    }
    
    private(set) var inGameCards: [Card] {
        didSet {
            if inGameCards.isEmpty { updateScore(by: Constant.Score.allCardsMatched) }
        }
    }
    private(set) var deckCards: [Card]
    
    private(set) var score: Int
    private(set) var finalScore: Int?
    mutating private func updateScore(by offset: Int) {
        score += offset
    }
    
    init() {
        deckCards = Game.cards.shuffled()
        inGameCards = []
        score = Constant.Score.initialScore
        finalScore = nil
        
        deal(numberOfCards: Constant.initialNumberOfCardsOnDeck)
        lastMatchDate = Date()
    }
    
    private mutating func deal(numberOfCards: Int) {
        guard deckCards.count >= numberOfCards else { return }
        
        guard !(selectedCardsMakeASet ?? false) else {
            replaceSelectedCards()
            return
        }
        
        if inGameCardsContainSet { updateScore(by: Constant.Score.dealtWithAvailableSet) }
        
        let cardsToDeal = deckCards.prefix(numberOfCards)
        inGameCards.append(contentsOf: cardsToDeal)
        deckCards.removeFirst(numberOfCards)
    }
    
    mutating func deal() {
        deal(numberOfCards: Constant.numberOfCardsPerDeal)
    }
    
    private var inGameCardsContainSet: Bool {
        firstSetInGameCards() != nil
    }
    
    private func firstSetInGameCards() -> [Card]? {
        guard inGameCards.count > 0 else { return nil }
        
        let mySet = Set(inGameCards)
        
        for index1 in 0 ... (inGameCards.count - 3) {
            for index2 in (index1 + 1) ... (inGameCards.count - 2) {
                let match = matchForCards(card1: inGameCards[index1], card2: inGameCards[index2])
                if mySet.contains(match) { return [inGameCards[index1], inGameCards[index2], match] }
            }
        }
        return nil
    }
    
    private var selectedCards: [Card] {
        inGameCards.filter { $0.isSelected }
    }
    
    /// check whether three selected cards make a set; if less than three cards selected, returns nil
    private var selectedCardsMakeASet: Bool? {
        guard selectedCards.count == 3 else { return nil }
        
        let card1 = selectedCards[0]
        let card2 = selectedCards[1]
        let card3 = selectedCards[2]
        
        func featureIsAMatch<T: Equatable>(_ feature1: T, _ feature2: T, _ feature3: T) -> Bool {
            
            return (feature1 == feature2 && feature2 == feature3) ||
                   (feature1 != feature2 && feature1 != feature3 && feature2 != feature3)
        }
        
        return featureIsAMatch(card1.number, card2.number, card3.number) &&
            featureIsAMatch(card1.shape, card2.shape, card3.shape) &&
            featureIsAMatch(card1.color, card2.color, card3.color) &&
            featureIsAMatch(card1.shading, card2.shading, card3.shading)
    }
    
    private func matchForCards(card1: Card, card2: Card) -> Card {
        
        func matchingFeatureFor(feature1: Ternary, feature2: Ternary) -> Ternary {
            if feature1 == feature2 {
                return feature1
            }
            
            return Ternary
                    .allCases
                    .filter { $0 != feature1 && $0 != feature2 }
                    .first!
        }
        
        return Card(
            number: matchingFeatureFor(feature1: card1.number, feature2: card2.number),
            shape: matchingFeatureFor(feature1: card1.shape, feature2: card2.shape),
            color: matchingFeatureFor(feature1: card1.color, feature2: card2.color),
            shading: matchingFeatureFor(feature1: card1.shading, feature2: card2.shading))
    }
    
    mutating private func replaceSelectedCards() {
        for card in selectedCards {
            if let index = inGameCards.firstIndex(of: card) {
                inGameCards.remove(at: index)
                
                if let newCard = deckCards.first {
                    inGameCards.insert(newCard, at: index)
                    deckCards.removeFirst()
                }
            }
        }
        
        if !inGameCardsContainSet && deckCards.isEmpty {
            finalScore = score
        }
    }
    
    mutating private func resetStateOfSelectedCards() {
        for card in selectedCards {
            if let index = inGameCards.firstIndex(of: card) {
                inGameCards[index].isMatched = nil
                inGameCards[index].isSelected = false
            }
        }
    }
    
    mutating private func matchSelectedCards(success: Bool) {
        for card in selectedCards {
            if let index = inGameCards.firstIndex(of: card) {
                inGameCards[index].isMatched = success
            }
        }
        
        updateScore(by: success ?
                    cheatingMatch ?
                        Constant.Score.cheated :
                        Int((timeBonusMultiplier * Double(Constant.Score.matchSuccess)).rounded()) :
                    Constant.Score.matchError)
        cheatingMatch = false
        
        if success { lastMatchDate = Date() }
    }
    
    private var lastMatchDate: Date?
    
    private var timeElapsed: TimeInterval {
        return Date().timeIntervalSince(lastMatchDate ?? Date())
    }
    
    private var timeBonusMultiplier: Double {
        let timeBonusPercentage = max(Constant.Score.timeBonusInterval - timeElapsed, 0) / Constant.Score.timeBonusInterval
        return Double(1) + Constant.Score.timeBonusMultiplier * timeBonusPercentage
    }
    
    mutating func select(_ card: Card) {
        /// remove/reset previous set, valid or not
        if let matched = selectedCardsMakeASet {
            if matched {
                replaceSelectedCards()
            } else {
                resetStateOfSelectedCards()
            }
        }
        
        /// select card
        if let index = inGameCards.firstIndex(of: card) {
            inGameCards[index].toggleSelected()
        }
        
        /// check for match
        guard let matched = selectedCardsMakeASet else { return }
        matchSelectedCards(success: matched)
    }
    
    var cheatIsAvailable: Bool {
        return !(selectedCardsMakeASet ?? false) && inGameCardsContainSet
    }
    
    var cheatingMatch: Bool = false
    
    mutating func cheat() {
        guard let cards = firstSetInGameCards() else { return }
        
        resetStateOfSelectedCards()
        cheatingMatch = true
        for card in cards {
            select(card)
        }
    }
}
