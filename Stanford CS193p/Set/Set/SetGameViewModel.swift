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
    
    private static func createSetGame() -> SetGame {
        SetGame(numberOfCards: 81)
    }
    
    init() {
        model = SetGameViewModel.createSetGame()
        deal(numberOfCardsToDeal: 12)
    }
    
    func deal(numberOfCardsToDeal: Int) {
        model.deal(numberOfCardsToDeal: numberOfCardsToDeal)
    }
}
