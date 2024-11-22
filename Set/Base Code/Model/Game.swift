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
    
    mutating func select(_ card: Card) {
        if let index = visibleCards.firstIndex(of: card) {
            visibleCards[index].toggleSelected()
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

struct Card: Identifiable, Equatable, CustomDebugStringConvertible {
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Shape: String, CaseIterable {
        case diamond, oval, squiggle
    }
    
    enum Color: String, CaseIterable {
        case pink, purple, orange
    }
    
    enum Shading: String, CaseIterable {
        case solid, medium, open
    }
    
    let id = UUID()
    let number: Number
    let shape: Shape
    let color: Color
    let shading: Shading
    
    var isSelected: Bool = false
    
    mutating func toggleSelected() {
        isSelected.toggle()
    }
    
    var debugDescription: String {
        "Number: \(number);\n" +
        "Shape: \(shape);\n" +
        "Color: \(color);\n" +
        "Shading: \(shading)"
    }
}


