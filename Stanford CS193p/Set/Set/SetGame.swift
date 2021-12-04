//
//  SetGame.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import Foundation



struct SetGame {
    private(set) var deck: Array<Card> = []
    private(set) var selectedCardsIndex: Array<Int> = []
    private(set) var dealtCardsIndex: Array<Int> = []
    private var numberOfCardsDealt: Int = 0
    var selectedCardsMatched: Bool {
        if selectedCardsIndex.count == 3 {
            let card0 = deck[selectedCardsIndex[0]]
            let card1 = deck[selectedCardsIndex[1]]
            let card2 = deck[selectedCardsIndex[2]]
            
            let numbers: Set<ThreeState> = [card0.number, card1.number, card2.number]
            let shapes: Set<ThreeState> = [card0.shape, card1.shape, card2.shape]
            let shadings: Set<ThreeState> = [card0.shading, card1.shading, card2.shading]
            let colors: Set<ThreeState> = [card0.color, card1.color, card2.color]
            if numbers.count == 2 || shapes.count == 2 || shadings.count == 2 || colors.count == 2 {
                return false
            }
            return true
        }
        return false
    }
    
    init(numberOfCards: Int) {
        for cardIndex in 0..<numberOfCards {
            deck.append(createCard(cardIndex))
        }
        deck.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if selectedCardsIndex.count < 3 && selectedCardsIndex.contains(where: { deck[$0].id == card.id }) {
            return
        }
        if selectedCardsIndex.count == 3 {
            if selectedCardsMatched {
                selectedCardsIndex.forEach {
                    deck[$0].isMatched = true
                }
                deal(numberOfCardsToDeal: 3)
                if selectedCardsIndex.contains(where: { deck[$0].id == card.id }) {
                    selectedCardsIndex = []
                } else {
                    selectedCardsIndex = [deck.firstIndex(where: { $0.id == card.id })!]
                }
            } else {
                selectedCardsIndex = [deck.firstIndex(where: { $0.id == card.id })!]
            }
        } else {
            selectedCardsIndex.append(deck.firstIndex(where: { $0.id == card.id })!)
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
            if selectedCardsMatched {
                selectedCardsIndex.forEach {
                    deck[$0].isMatched = true
                }
                for cardIndex in numberOfCardsDealt..<(numberOfCardsDealt + numberOfCardsToDeal) {
                    deck[cardIndex].isDealt = true
                    if cardIndex < (numberOfCardsDealt + 3) {
                        dealtCardsIndex[dealtCardsIndex.firstIndex(of: selectedCardsIndex[cardIndex - numberOfCardsDealt])!] = cardIndex
                    } else {
                        dealtCardsIndex.append(cardIndex)
                    }
                }
            } else {
                for cardIndex in numberOfCardsDealt..<(numberOfCardsDealt + numberOfCardsToDeal) {
                    deck[cardIndex].isDealt = true
                    dealtCardsIndex.append(cardIndex)
                }
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
