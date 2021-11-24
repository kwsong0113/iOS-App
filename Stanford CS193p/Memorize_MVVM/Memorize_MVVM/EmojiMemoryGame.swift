//
//  EmojiMemoryGame.swift
//  Memorize_MVVM
//
//  Created by user206692 on 11/19/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model: MemoryGame<String>
    private var theme: Theme<String>
    
    private static func createMemoryGame(theme: Theme<String>) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairsOfCardsToShow = theme.numberOfPairsOfCards ?? Int.random(in: 3...theme.emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCardsToShow) {
            pairIndex in emojis[pairIndex]
        }
    }
    
    init() {
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var themeName: String {
        return theme.name
    }
    
    var score: Int {
        return model.score
    }
    
    var color: Color {
        switch theme.color {
        case "red": return Color.red
        case "blue": return Color.blue
        case "green": return Color.green
        case "purple": return Color.purple
        default: return Color.black
        }
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card:  Card){
//        objectWillChange.send()
        model.choose(card)
    }
    
    func startNewGame() {
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
