//
//  Card.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 22/11/24.
//

import Foundation

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
    var isMatched: Bool?
    
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
