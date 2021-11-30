//
//  SegGameView.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        AspectVGrid(itemCount: viewModel.numberOfCardsToShow, items: viewModel.deck, aspectRatio: 2/3) { card in
            if card.isDealt {
                CardView(card: card)
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
