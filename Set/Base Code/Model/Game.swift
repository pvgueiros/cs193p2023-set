//
//  Game.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import Foundation

struct Game {
    
    // MARK: - Constants
    
    static let initialNumberOfCardsOnDeck: Int = 12
    static let numberOfCardsPerDeal = 3
    
    static private let cards: [Card] = createAllCards()
    static private func createAllCards() -> [Card] {
        var cards = [Card]()
        
        for number in Card.Number.allCases {
            for shape in Card.Shape.allCases {
                for color in Card.Color.allCases {
                    for shading in Card.Shading.allCases {
                        let card = Card(number: number, shape: shape, color: color, shading: shading)
                        cards.append(card)
                    }
                }
            }
        }
        return cards
    }
    
    private(set) var visibleCards: [Card]
    private(set) var deckCards: [Card]
    
    init() {
        deckCards = Game.cards.shuffled()
        visibleCards = []
        
        deal(numberOfCards: Self.initialNumberOfCardsOnDeck)
    }
    
    private var selectedCards: [Card] {
        visibleCards.filter { $0.isSelected }
    }
    
    
    // TODO: - if needed, add mechanism to prevent from selecting matched cards
    
    
    
    private func selectedCardsMakeASet() -> Bool {
        guard selectedCards.count == 3 else { return false }
        
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
    
    mutating func select(_ card: Card) {
        
        // TODO: - when there are 3 cards selected and user clicks on any card:
                    // first, remove matched cards ✅
                    // second, reset (isMatched = nil) and (isSelected = false) for all cards ✅
                    // third, select touched card IF not part of a match ✅
                    // fourth, if cards < 12, deal 3 more cards ✅
        if selectedCards.count == 3 {
            for (index, _) in visibleCards.enumerated() {
                if visibleCards[index].isMatched ?? false {
                    visibleCards.remove(at: index)
                } else {
                    visibleCards[index].isMatched = nil
                    visibleCards[index].isSelected = false
                }
            }
            
            if visibleCards.count < 12 {
                deal()
            }
        }
        
        if let index = visibleCards.firstIndex(of: card) {
            visibleCards[index].toggleSelected()
        }
        
        if selectedCards.count == 3 {
            let match = selectedCardsMakeASet()
            
            for card in selectedCards {
                if let index = visibleCards.firstIndex(of: card) {
                    visibleCards[index].isMatched = match
                }
            }
        }
    }
    
    private mutating func deal(numberOfCards: Int) {
        guard deckCards.count >= numberOfCards else { return }
        
        let cardsToDeal = deckCards.prefix(numberOfCards)
        visibleCards.append(contentsOf: cardsToDeal)
        deckCards.removeFirst(numberOfCards)
    }
    
    mutating func deal() {
        deal(numberOfCards: Self.numberOfCardsPerDeal)
    }
}
