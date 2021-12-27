//
//  EmojiMemoryGame.swift
//  Memorize_Final
//
//  Created by user211007 on 12/27/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    static let emojis = ["✈️", "🚁", "🛶", "🚞", "🏍", "🚲", "🚘", "🚍", "🚀", "🛳", "🚛", "🚠", "🛺", "🚒", "🚜", "🦽", "🛴", "🛸", "⛵️", "🛩", "🛰", "🚂", "🦼", "🏎"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in emojis[pairIndex] }
    }

    @Published private var model: MemoryGame<String> = createMemoryGame()

    var cards: Array<Card> {
        return model.cards
    }

    //MARK: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
