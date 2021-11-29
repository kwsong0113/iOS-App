//
//  SetGame.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import Foundation



struct SetGame {
    private(set) var deck: Array<Card>
    private var numberOfCardsDealt = 0
    
    init(numberOfCards: Int) {
        deck = []
        for cardIndex in 0..<numberOfCards {
            deck.append(createCard(cardIndex))
        }
        deck.shuffle()
    }
    
    private func createCard(_ cardIndex: Int) -> Card {
        return Card(id: cardIndex, number: intToState(cardIndex / 27), shape: intToState(cardIndex / 9), shading: intToState(cardIndex / 3), color: intToState(cardIndex))
    }
    
    private func intToState(_ index: Int) -> ThreeState {
        switch index % 3 {
        case 1: return .one
        case 2: return .two
        default: return .three
        }
    }
    
    mutating func deal(numberOfCardsToDeal: Int) {
        if numberOfCardsDealt < deck.count {
            for cardIndex in numberOfCardsDealt..<(numberOfCardsDealt + numberOfCardsToDeal) {
                deck[cardIndex].isDealt = true
            }
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        let number: ThreeState
        let shape: ThreeState
        let shading: ThreeState
        let color: ThreeState
        var isMatched = false
        var isDealt = false
        var isSelected = true
    }
    
    enum ThreeState: Int {
        case one = 1
        case two = 2
        case three = 3
    }
}
