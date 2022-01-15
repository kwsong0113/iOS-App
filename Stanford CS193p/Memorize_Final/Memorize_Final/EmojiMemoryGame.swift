//
//  EmojiMemoryGame.swift
//  Memorize_Final
//
//  Created by user211007 on 12/27/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private var theme: Theme
    @Published private var dealt = Set<Int>()
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme)
    }
    
    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in String(emojis[pairIndex]) }
    }
    
    @Published private var model: MemoryGame<String>

    var cards: Array<Card> {
        return model.cards
    }
    
    var color: Color {
        return theme.color
    }

    //MARK: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(theme)
        dealt = []
    }
    
    func deal(_ card: Card) {
        dealt.insert(card.id)
    }
    
    func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
}
