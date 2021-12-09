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
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2 / 3) { card in
            CardView(card: card, viewModel: viewModel)
                .matchedGeometryEffect(id: card.id, in: cardNamespace)
                .padding(4)
                .onTapGesture {
                    withAnimation(.linear(duration: 1)) {
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
            }
        }
        .frame(width: 60, height: 90)
        .foregroundColor(.black)
        .onTapGesture {
            var numberOfCardsToDeal = viewModel.deck.count == 81 ? 12 : 3
            if viewModel.state == .matched {
                for _ in 0..<3 {
                    withAnimation(.linear(duration: 3)) {
                        viewModel.dealAndDiscard()
                    }
                }
                numberOfCardsToDeal -= 3
            }
            for _ in 0..<numberOfCardsToDeal {
                withAnimation(.linear(duration: 3)) {
                    viewModel.deal()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SetGameViewModel()
        return SetGameView(viewModel: viewModel)
    }
}
