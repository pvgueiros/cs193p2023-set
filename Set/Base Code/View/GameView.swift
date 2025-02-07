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
        static let defaultHorizontalPadding: CGFloat = 25
        static let headerHorizontalSpacing: CGFloat = 15
        static let gridHorizontalPadding: CGFloat = 10
        static let footerHeight: CGFloat = 75
        static let footerVerticalSpacing: CGFloat = 20
        static let minimumFontScale: CGFloat = 0.6
        
        struct Animation {
            static let scoreDefaultOpacity: TimeInterval = 1
            static let scoreEndGameOpacity: TimeInterval = 0
            static let defaultDuration: TimeInterval = 0.5
        }
    }
    
    var body: some View {
        VStack(spacing: Constant.defaultInset) {
            header
            cardGrid
                .overlay { GameOverView(
                    isGameOver: gameViewModel.isGameOver,
                    score: gameViewModel.score) }
            footer
        }
        .background(Color.Base.background)
        .onAppear {
            withAnimation {
                gameViewModel.deal()
            }
        }
    }
    
    var header: some View {
        HStack {
            HStack(spacing: Constant.headerHorizontalSpacing) {
                cheatButton
                shuffleButton
            }
            .lineLimit(1).minimumScaleFactor(Constant.minimumFontScale)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            title.frame(maxWidth: .infinity, alignment: .center)
            newGameButton.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, Constant.defaultHorizontalPadding)
    }
    
    var title: some View {
        Text("SET")
            .font(Font.title)
    }
    
    var newGameButton: some View {
        Button {
            withAnimation(.easeInOut(duration: Constant.Animation.defaultDuration)) {
                gameViewModel.createNewGame()
            }
            withAnimation(.easeInOut.delay(Constant.Animation.defaultDuration)) {
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
        .padding(.horizontal, Constant.gridHorizontalPadding)
    }
    
    var footer: some View {
        HStack {
            discardPileView.frame(maxWidth: .infinity, alignment: .leading)
            scoringArea.frame(maxWidth: .infinity, alignment: .center)
            deckView.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(Font.body)
        .padding(.vertical, Constant.defaultInset)
        .padding(.horizontal, Constant.defaultHorizontalPadding)
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
            .minimumScaleFactor(Constant.minimumFontScale)
            .opacity(gameViewModel.isGameOver
                     ? Constant.Animation.scoreEndGameOpacity
                     : Constant.Animation.scoreDefaultOpacity)
            .animation(nil, value: gameViewModel.score)
    }
    
    var highScoreView: some View {
        Text("High Score: \(gameViewModel.highScore)")
            .font(.small)
            .minimumScaleFactor(Constant.minimumFontScale)
            .animation(nil, value: gameViewModel.highScore)
    }
    
    var deckView: some View {
        ZStack {
            ForEach(Array(gameViewModel.deckCards.reversed().enumerated()), id: \.offset) { index, card in
                CardView(card)
                    .aspectRatio(Constant.cardAspectRatio, contentMode: .fit)
                    .matchedGeometryEffect(id: card.id, in: dealingAnimation)
                    .matchedGeometryEffect(id: card.id, in: restartingAnimation)
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
