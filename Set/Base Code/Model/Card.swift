//
//  Card.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 22/11/24.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    let number, shape, color, shading: Ternary
    
    var isSelected: Bool = false
    var isMatched: Bool?
    private(set) var isFaceUp: Bool = false
    
    mutating func toggleSelected() {
        isSelected.toggle()
    }
    
    mutating func show() {
        isFaceUp = true
    }
    
    mutating func resetState() {
        self.isSelected = false
    }
    
    // MARK: - FOR DEBUG ONLY
    
    mutating func toggleFaceUp() {
        isFaceUp = !isFaceUp
    }
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.number == rhs.number &&
        lhs.shape == rhs.shape &&
        lhs.color == rhs.color &&
        lhs.shading == rhs.shading
    }
}

extension Card: CustomDebugStringConvertible {
    var debugDescription: String {
        "Number: \(number); " +
        "Shape: \(shape); " +
        "Color: \(color); " +
        "Shading: \(shading)"
    }
}

extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
        hasher.combine(shape)
        hasher.combine(color)
        hasher.combine(shading)
    }
}
