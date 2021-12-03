//
//  SetGame.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import Foundation



struct SetGame {
    private(set) var deck: Array<Card>
    private(set) var selectedCards: Array<Card>
    private var numberOfCardsDealt = 0
    var selectedCardsMatched: Bool {
        if selectedCards.count == 3 {
            let numbers: Set<ThreeState> = [selectedCards[0].number, selectedCards[1].number, selectedCards[2].number]
            let shapes: Set<ThreeState> = [selectedCards[0].shape, selectedCards[1].shape, selectedCards[2].shape]
            let shadings: Set<ThreeState> = [selectedCards[0].shading, selectedCards[1].shading, selectedCards[2].shading]
            let colors: Set<ThreeState> = [selectedCards[0].color, selectedCards[1].color, selectedCards[2].color]
            if numbers.count == 2 || shapes.count == 2 || shadings.count == 2 || colors.count == 2 {
                return false
            }
            return true
        }
        return false
    }
    
    init(numberOfCards: Int) {
        deck = []
        selectedCards = []
        for cardIndex in 0..<numberOfCards {
            deck.append(createCard(cardIndex))
        }
        deck.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if selectedCards.count == 3 {
            if selectedCardsMatched {
                for index in 0..<3 {
                    selectedCards[index].isMatched = true
                }
                deal(numberOfCardsToDeal: 3)
                if selectedCards.contains(where: { $0.id == card.id }) {
                    selectedCards = []
                } else {
                    selectedCards = [card]
                }
            } else {
                selectedCards = [card]
            }
        } else {
            selectedCards.append(card)
        }
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
            numberOfCardsDealt += numberOfCardsToDeal
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
    }
    
    enum ThreeState: Int {
        case one = 1
        case two = 2
        case three = 3
    }
}
