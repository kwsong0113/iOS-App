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
        AspectVGrid(itemCount: 12, items: viewModel.deck, aspectRatio: 2/3) { card in
            if card.isDealt {
                CardView(card: card)
            }
            
        }
        
    }
}

struct CardView: View {
    let card: SetGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 15)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                VStack {
                    Text("\(card.number.rawValue)")
                    Text("\(card.shape.rawValue)")
                    Text("\(card.shading.rawValue)")
                    Text("\(card.color.rawValue)")
                }
                .font(.footnote)
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
