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
        static let bodyHorizontalPadding: CGFloat = 20
        static let footerHeight: CGFloat = 76
        static let footerVerticalSpacing: CGFloat = 20
        static let minimumFontScale: CGFloat = 0.6
        
        struct Animation {
            static let cardDealingDelay: TimeInterval = 0.5
        }
    }
    
    var body: some View {
        VStack(spacing: Constant.defaultInset) {
            header
            cardGrid
            footer
        }
        .padding(.horizontal, Constant.bodyHorizontalPadding)
        .background(Color.Base.background)
    }
    
    var header: some View {
        HStack {
            HStack(spacing: Constant.bodyHorizontalPadding) {
                cheatButton
                shuffleButton
            }
            .lineLimit(1).minimumScaleFactor(Constant.minimumFontScale)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            title.frame(maxWidth: .infinity, alignment: .center)
            newGameButton.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, Constant.defaultInset)
    }
    
    var title: some View {
        Text("SET")
            .font(Font.title)
            .padding(.top, Constant.defaultInset)
    }
    
    var newGameButton: some View {
        Button {
            withAnimation {
                gameViewModel.createNewGame()
            }
            withAnimation(.easeInOut.delay(Constant.Animation.cardDealingDelay)) {
                gameViewModel.deal()
            }
        } label: {
            Text("New Game")
        }
        .font(.small)
    }
    
    var cheatButton: some View {
        Button(action: gameViewModel.cheat) {
            Text("Cheat")
        }
        .font(.small)
        .disabled(!gameViewModel.cheatButtonEnabled)
    }
    
    var shuffleButton: some View {
        Button {
            withAnimation {
                gameViewModel.shuffleCards()
            }
        } label: {
            Text("Shuffle")
        }
        .font(.small)
    }
    
    @Namespace private var dealingAnimation
    @Namespace private var discardingAnimation
    @Namespace private var restartingAnimation
    
    var cardGrid: some View {
        AspectVGrid(gameViewModel.inGameCards, aspectRatio: Constant.cardAspectRatio) { card in
            CardView(card)
                .matchedGeometryEffect(id: card.id, in: dealingAnimation)
                .matchedGeometryEffect(id: card.id, in: discardingAnimation)
                .padding(Constant.defaultInset)
                .onTapGesture {
                    withAnimation {
                        gameViewModel.select(card)
                    }
                }
        }
    }
    
    var footer: some View {
        HStack {
            discardPileView.frame(maxWidth: .infinity, alignment: .leading)
            scoringArea.frame(maxWidth: .infinity, alignment: .center)
            deckView.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(Font.body)
        .padding(.top, Constant.defaultInset)
        .padding(.horizontal, Constant.defaultInset)
        .frame(maxHeight: Constant.footerHeight)
    }
    
    var scoringArea: some View {
        VStack(spacing: Constant.footerVerticalSpacing) {
            currentScoreView
            highScoreView
        }
    }
    
    var currentScoreView: some View {
        Text("Score: \(gameViewModel.score)")
            .animation(nil)
    }
    
    var highScoreView: some View {
        Text("High Score: \(gameViewModel.highScore)")
            .animation(nil)
            .font(.small)
            .minimumScaleFactor(Constant.minimumFontScale)
    }
    
    var deckView: some View {
        ZStack {
            ForEach(Array(gameViewModel.deckCards.reversed().enumerated()), id: \.offset) { index, card in
                CardView(card)
                    .aspectRatio(Constant.cardAspectRatio, contentMode: .fit)
                    .matchedGeometryEffect(id: card.id, in: dealingAnimation)
                    .matchedGeometryEffect(id: card.id, in: restartingAnimation)
                    .zIndex(Double(index))
            }
        }
        .onTapGesture {
            withAnimation {
                gameViewModel.deal()
            }
        }
    }
    
    var discardPileView: some View {
        ZStack {
            ForEach(gameViewModel.discardedCards) { card in
                CardView(card)
                    .aspectRatio(Constant.cardAspectRatio, contentMode: .fit)
                    .matchedGeometryEffect(id: card.id, in: discardingAnimation)
                    .matchedGeometryEffect(id: card.id, in: restartingAnimation)
            }
        }
    }
}

#Preview {
    GameView(gameViewModel: GameViewModel())
}
