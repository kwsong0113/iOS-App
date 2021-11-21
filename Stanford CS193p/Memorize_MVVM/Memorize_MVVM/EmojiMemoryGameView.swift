//
//  EmojiMemoryGameView.swift
//  Memorize_MVVM
//
//  Created by user206692 on 11/17/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack {
                        Text("\(game.score)")
                        Text("Score").font(.footnote)
                    }
                    Spacer()
                    Button {
                        game.startNewGame()
                    } label: {
                        VStack {
                            Image(systemName: "play.circle")
                            Text("New Game").font(.footnote)
                        }
                    }
                }
                .padding(.horizontal)
            Text(game.themeName)
            }
            .foregroundColor(.mint)
            .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
        }
        .foregroundColor(game.color)
        .padding(.horizontal)
    }
}
                                                    

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
