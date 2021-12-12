//
//  ContentView.swift
//  Animated Set
//
//  Created by user206692 on 12/7/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    @Namespace private var cardNamespace
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    newGame
                    Spacer()
                }
                gameBody
            }
            Spacer()
            HStack {
                deckBody
                Spacer()
                discardedBody
            }
        }
        .padding()
    }
    
    private func flipCardAnimation(_ index: Int) -> Animation {
        var delay = 0.0
        delay = Double(index) * CardConstants.dealDelay + CardConstants.dealDuration
        return Animation.easeInOut(duration: CardConstants.flipCardDuration).delay(delay)
    }
    
    private func dealAnimation(_ index: Int) -> Animation {
        var delay = 0.0
        delay = Double(index) * CardConstants.dealDelay
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2 / 3) { card in
            CardView(card: card, viewModel: viewModel)
                .matchedGeometryEffect(id: card.id, in: cardNamespace)
                .padding(4)
                .zIndex(162.0 - Double(viewModel.cards.firstIndex(where: { $0.id == card.id })!))
                .onTapGesture {
                    if viewModel.state == .matched {
                        for index in 0..<3 {
                            withAnimation(dealAnimation(index)) {
                                viewModel.discard()
                            }
                        }
                    }
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
                
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.deck) { card in
                CardView(card: card, viewModel: viewModel)
                    .matchedGeometryEffect(id: card.id, in: cardNamespace)
                    .zIndex(Double(viewModel.deck.firstIndex(where: { $0.id == card.id })!))
            }
        }
        .frame(width: 60, height: 90)
        .foregroundColor(.black)
        .onTapGesture {
            var numberOfCardsToDeal = viewModel.deck.count == 81 ? 12 : 3
            if viewModel.state == .matched {
                for index in 0..<3 {
                    if !viewModel.deck.isEmpty {
                        withAnimation(dealAnimation(index)) {
                            viewModel.dealAndDiscard()
                        }
                        withAnimation(flipCardAnimation(index)) {
                            viewModel.flipCard()
                        }
                    }
                }
                numberOfCardsToDeal -= 3
            }
            for index in 0..<numberOfCardsToDeal {
                if !viewModel.deck.isEmpty {
                    withAnimation(dealAnimation(index)) {
                        viewModel.deal()
                    }
                    withAnimation(flipCardAnimation(index)) {
                        viewModel.flipCard()
                    }
                }
            }
        }
    }
    
    var discardedBody: some View {
        ZStack {
            ForEach(viewModel.discardedCards) { card in
                CardView(card: card, viewModel: viewModel)
                    .matchedGeometryEffect(id: card.id, in: cardNamespace)
            }
        }
        .frame(width: 60, height: 90)
        .foregroundColor(.black)
    }
    
    var newGame: some View {
        Button("New Game") {
            withAnimation {
                viewModel.startNewGame()
            }
        }
    }

    private struct CardConstants {
        static let dealDelay = 0.2
        static let dealDuration = 1.6
        static let flipCardDuration = 1.2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SetGameViewModel()
        return SetGameView(viewModel: viewModel)
    }
}
