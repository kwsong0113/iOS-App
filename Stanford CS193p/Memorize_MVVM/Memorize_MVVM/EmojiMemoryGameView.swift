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
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
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
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
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
