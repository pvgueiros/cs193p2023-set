//
//  Theme.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import SwiftUI

extension Color {
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let appBackground = Color("Background")
    
    static let orange = Color("Orange")
    static let pink = Color("Pink")
    static let purple = Color("Purple")
    
    struct Border {
        static let selected = Color("Selected")
        static let success = Color("Success")
        static let error = Color("Error")
    }
}
    
extension Font {
    static let title = Font.custom("Marker Felt", size: 50)
    static let body = Font.custom("Marker Felt", size: 26)
}
