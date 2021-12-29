//
//  Theme.swift
//  Memorize_Final
//
//  Created by user211007 on 12/27/21.
//

import Foundation

struct Theme: Identifiable, Hashable {
    var name: String
    var emojis: String
    var numberOfPairsOfCards: Int
    var id: Int
    var rgbaColor: RGBAColor
}
