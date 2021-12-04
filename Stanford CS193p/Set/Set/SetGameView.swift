//
//  SegGameView.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var newGame: some View {
        Button {
            viewModel.startNewGame()
        } label: {
            VStack {
                Image(systemName: "arrow.clockwise.circle")
                Text("New Game").font(.caption)
            }
        }
    }
    
    var dealThreeMoreCards: some View {
        Button {
            viewModel.deal(numberOfCardsToDeal: 3)
        } label: {
            VStack {
                Image(systemName: "plus.circle")
                Text("+3 Cards").font(.caption)
            }
        }
        .disabled(viewModel.numberOfCardsDealt == 81)
    }
    
    var body: some View {
        VStack {
            HStack {
                newGame
                Spacer()
                dealThreeMoreCards
            }
            .padding([.horizontal, .top])
            .font(.largeTitle)
            .foregroundColor(.black)
            AspectVGrid(itemIndices: viewModel.dealtCardsIndex, items: viewModel.deck, aspectRatio: 2/3) { card in
                if !card.isMatched {
                    CardView(card: card, viewModel: viewModel)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
                
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
