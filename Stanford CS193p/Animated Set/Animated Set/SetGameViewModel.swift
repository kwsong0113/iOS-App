//
//  SetGameViewModel.swift
//  Animated Set
//
//  Created by user206692 on 12/7/21.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    @Published private var model: SetGame = SetGameViewModel.createSetGame()
    
    var deck: Array<Card> {
        return model.deck
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var discardedCards: Array<Card> {
        return model.discardedCards
    }
    
    var state: SelectionState {
        return model.state
    }
    
    private static func createSetGame() -> SetGame {
        SetGame(numberOfCards: 81)
    }
    
    // MARK: - Intent(s)

    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func deal() {
        model.deal()
    }
    
    func flipCard() {
        model.flipCard()
    }
    
    func dealAndDiscard() {
        model.dealAndDiscard()
    }
    
    func startNewGame() {
        model = SetGameViewModel.createSetGame()
    }
}
