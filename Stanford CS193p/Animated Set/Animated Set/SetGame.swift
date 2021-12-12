//
//  SetGame.swift
//  Animated Set
//
//  Created by user206692 on 12/7/21.
//

import Foundation

struct SetGame {
    private(set) var deck: Array<Card> = []
    private(set) var discardedCards: Array<Card> = []
    private(set) var cards: Array<Card> = []
    private var chosenCards: Array<Card> {
        return cards.filter({ $0.isSelected })
    }
    var state: SelectionState {
        var numbers: Set<ThreeState> = []
        var shapes: Set<ThreeState> = []
        var shadings: Set<ThreeState> = []
        var colors: Set<ThreeState> = []
        chosenCards.forEach {
            numbers.insert($0.number); shapes.insert($0.shape); shadings.insert($0.shading); colors.insert($0.color)
        }
        if chosenCards.count == 3 {
            if numbers.count == 2 || shapes.count == 2 || shadings.count == 2 || colors.count == 2 {
                return .mismatched
            }
            return .matched
        }
        return .lessThanThreeCards
    }
    
    var lastDealtCard: Card? = nil
    
    init(numberOfCards: Int) {
        for cardIndex in 0..<numberOfCards {
            deck.append(createCard(cardIndex))
        }
        deck.shuffle()
    }
    
    private func createCard(_ cardIndex: Int) -> Card {
        return Card(id: cardIndex, number: intToThreeState(cardIndex / 27), shape: intToThreeState(cardIndex / 9), shading: intToThreeState(cardIndex / 3), color: intToThreeState(cardIndex))
    }
    
    private func intToThreeState(_ index: Int) -> ThreeState {
        switch index % 3 {
        case 1: return .one
        case 2: return .two
        default: return .three
        }
    }
    
    mutating func choose(_ card: Card){
        let index: Int? = cards.firstIndex(where: { $0.id == card.id })
        switch state {
        case .mismatched:
            cards.indices.forEach { cards[$0].isSelected = false }
            cards[index!].isSelected = true
        case .lessThanThreeCards:
            if let cardIndex = index {
                cards[cardIndex].isSelected.toggle()
            }
        default: break
        }
        print("\(card)")
    }
    
    mutating func deal() {
        lastDealtCard = deck.removeLast()
        cards.append(lastDealtCard!)
    }
    
    mutating func flipCard() {
        cards[cards.firstIndex(where: { $0.id == lastDealtCard!.id })!].isFaceUp = true
    }
    
    mutating func dealAndDiscard() {
        let index: Int = discard()
        lastDealtCard = deck.removeLast()
        cards.insert(lastDealtCard!, at: index)
    }
    
    mutating func discard() -> Int {
        discardedCards.append(chosenCards.last!)
        discardedCards[discardedCards.count - 1].isSelected = false
        let index: Int = cards.firstIndex(where: { $0.id == chosenCards.last!.id })!
        cards.remove(at: index)
        return index
    }
    
    struct Card: Identifiable {
        let id: Int
        let number: ThreeState
        let shape: ThreeState
        let shading: ThreeState
        let color: ThreeState
        var isFaceUp: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
    }
    
    enum ThreeState: Int {
        case one = 1
        case two = 2
        case three = 3
    }
}

enum SelectionState {
    case matched
    case mismatched
    case lessThanThreeCards
}
