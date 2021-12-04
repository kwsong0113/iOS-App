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
    
    var selectedCardsIndex: Array<Int> {
        return model.selectedCardsIndex
    }
    
    var dealtCardsIndex: Array<Int> {
        return model.dealtCardsIndex
    }
    
    var numberOfCardsDealt: Int {
        return model.numberOfCardsDealt
    }
    
    var selectedCardsMatched: Bool {
        return model.selectedCardsMatched
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
    
    func startNewGame() {
        model = SetGameViewModel.createSetGame()
        deal(numberOfCardsToDeal: 12)
    }
}
