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
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    newGame
                    Spacer()
                }
                gameBody
            }
            HStack {
                deckBody
                discardedBody
            }
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2 / 3) { card in
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: cardNamespace)
                .padding(4)
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
