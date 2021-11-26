//
//  SetGame.swift
//  Set
//
//  Created by user206692 on 11/26/21.
//

import Foundation



struct SetGame {
    
    
    struct Card {
        let number: ThreeState
        let shape: ThreeState
        let shading: ThreeState
        let color: ThreeState
    }
}


enum ThreeState: Int {
    case one = 1
    case two = 2
    case three = 3
}
