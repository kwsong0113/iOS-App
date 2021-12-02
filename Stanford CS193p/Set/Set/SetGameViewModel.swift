//
//  SetGameViewModel.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    
    @Published private var model: SetGame
    
    var deck: Array<Card> {
        return model.deck
    }
    
    var selectedCards: Array<Card> {
        return model.selectedCards
    }
    
    var selectedCardsMatched: Bool {
        return model.selectedCardsMatched
    }
    
    var numberOfCardsToShow: Int {
        var numberOfCards = 0
        deck.forEach { card in
            if card.isDealt {
                numberOfCards += 1
            }
        }
        return numberOfCards
    }
    
    private static func createSetGame() -> SetGame {
        SetGame(numberOfCards: 81)
    }
    
    init() {
        model = SetGameViewModel.createSetGame()
        deal(numberOfCardsToDeal: 12)
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func deal(numberOfCardsToDeal: Int) {
        model.deal(numberOfCardsToDeal: numberOfCardsToDeal)
    }
}
