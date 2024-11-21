//
//  SetApp.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 14/11/24.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(gameViewModel: GameViewModel())
        }
    }
}
