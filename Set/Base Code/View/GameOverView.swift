//
//  GameOverView.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 05/02/25.
//

import SwiftUI

struct GameOverView: View {
    let isGameOver: Bool
    let score: Int
    
    struct Constant {
        static let animationDuration: TimeInterval = 1

        static let initialScale: TimeInterval = 0
        static let finalScale: TimeInterval = 1.0
        static let initialRotation: TimeInterval = 0
        static let finalRotation: TimeInterval = 360
    }
    
    var body: some View {
        gameOverTextView
            .foregroundColor(.black)
            .scaleEffect(isGameOver
                         ? Constant.finalScale
                         : Constant.initialScale)
            .rotationEffect(.degrees(isGameOver
                                     ? Constant.finalRotation
                                     : Constant.initialRotation))
            .animation(.bouncy(duration: Constant.animationDuration), value: isGameOver)
    }
    
    var gameOverTextView: some View {
        VStack {
            if isGameOver {
                Text(isGameOver ? "GAME OVER" : "")
                    .font(.title)
                Text("Final Score: \(score)")
                    .font(.body)
            }
        }
    }
    
}

#Preview {
    GameOverView(isGameOver: true, score: 100)
}
