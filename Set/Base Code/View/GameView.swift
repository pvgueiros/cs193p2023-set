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
        static let cardAspectRatio: CGFloat = 63/80
        static let dealButtonWidth: CGFloat = 60
        static let bodyHorizontalInset: CGFloat = 20
    }
    
    var body: some View {
        VStack(spacing: Constant.inset) {
            header
            cardsView
            footer
        }
        .padding(.horizontal, Constant.bodyHorizontalInset)
        .background(Color.appBackground)
    }
    
    var header: some View {
        Text("THE SET GAME")
            .font(Font.title)
            .padding(.top, Constant.inset)
    }
    
    var cardsView: some View {
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
            scoreView
            Spacer()
            dealButton
            Spacer()
            newGameButton
        }
        .font(Font.body)
        .padding(.top, Constant.inset)
        .padding(.horizontal, Constant.inset)
    }
    
    var scoreView: some View {
        Text("Score: \(gameViewModel.score)")
    }
    
    var dealButton: some View {
        Button(action: gameViewModel.deal) {
            Text("Deal")
        }
        .cardify(isSelected: false)
        .aspectRatio(Constant.cardAspectRatio, contentMode: .fit)
        .frame(maxWidth: Constant.dealButtonWidth)
    }
    
    var newGameButton: some View {
        Button(action: gameViewModel.createNewGame) {
            Text("New Game")
        }
    }
}

#Preview {
    GameView(gameViewModel: GameViewModel())
}
