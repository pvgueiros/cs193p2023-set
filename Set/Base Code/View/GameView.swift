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
        static let defaultInset: CGFloat = 5
        static let cardAspectRatio: CGFloat = 63/80
        static let dealButtonWidth: CGFloat = 60
        static let bodyHorizontalPadding: CGFloat = 20
        static let footerVerticalSpacing: CGFloat = 20
    }
    
    var body: some View {
        VStack(spacing: Constant.defaultInset) {
            header
            cardsView
            footer
        }
        .padding(.horizontal, Constant.bodyHorizontalPadding)
        .background(Color.Base.background)
    }
    
    var header: some View {
        Text("THE SET GAME")
            .font(Font.title)
            .padding(.top, Constant.defaultInset)
    }
    
    var cardsView: some View {
        AspectVGrid(gameViewModel.cards, aspectRatio: Constant.cardAspectRatio) { card in
            CardView(card)
                .padding(Constant.defaultInset)
                .onTapGesture {
                    gameViewModel.select(card)
                }
        }
    }
    
    var footer: some View {
        HStack {
            scoringArea
            Spacer()
            dealButton
            Spacer()
            actionArea
        }
        .font(Font.body)
        .padding(.top, Constant.defaultInset)
        .padding(.horizontal, Constant.defaultInset)
    }
    
    var scoringArea: some View {
        VStack(alignment: .leading, spacing: Constant.footerVerticalSpacing) {
            currentScoreView
            highScoreView
        }
    }
    
    var currentScoreView: some View {
        Text("Score: \(gameViewModel.score)")
    }
    
    var highScoreView: some View {
        Text("High Score: -")
            .font(.small)
    }
    
    var dealButton: some View {
        Button(action: gameViewModel.deal) {
            Text("Deal")
        }
        .disabled(!gameViewModel.deckHasCards)
        .cardify(isSelected: false, isMatched: nil)
        .aspectRatio(Constant.cardAspectRatio, contentMode: .fit)
        .frame(maxWidth: Constant.dealButtonWidth)
    }
    
    var actionArea: some View {
        VStack(alignment: .trailing, spacing: Constant.footerVerticalSpacing) {
            newGameButton
            cheatButton
        }
    }
    
    var newGameButton: some View {
        Button(action: gameViewModel.createNewGame) {
            Text("New Game")
        }
    }
    
    var cheatButton: some View {
        Button(action: gameViewModel.cheat) {
            Text("Cheat")
        }
        .font(.small)
        .disabled(!gameViewModel.cheatButtonEnabled)
    }
}

#Preview {
    GameView(gameViewModel: GameViewModel())
}
