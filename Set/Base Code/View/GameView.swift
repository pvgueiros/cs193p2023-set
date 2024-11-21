//
//  GameView.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 14/11/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    private struct Constant {
        static let inset: CGFloat = 5
        static let cardAspectRatio: CGFloat = 63/88
    }
    
    var body: some View {
        VStack {
            Text("THE SET GAME")
                .font(.custom("Marker Felt", size: 50))
            cards
            Spacer()
            footer
        }
        .padding()
        .background(Color("Background"))
    }
    
    var cards: some View {
        AspectVGrid(gameViewModel.cards, aspectRatio: Constant.cardAspectRatio) { card in
            CardView(card)
                .padding(Constant.inset)
                .onTapGesture {
                    gameViewModel.select(card)
                }
        }
    }
    
    var footer: some View {
        HStack {
            Text("Score: 0")
                .font(.custom("Marker Felt", size: 26))
            Spacer()
            Button(action: gameViewModel.createNewGame) {
                Text("New Game")
            }
            .font(.custom("Marker Felt", size: 26))
        }
        .font(.title3)
        .padding()
    }
}

#Preview {
    GameView(gameViewModel: GameViewModel())
}
