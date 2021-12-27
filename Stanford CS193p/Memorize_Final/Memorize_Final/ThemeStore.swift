//
//  ThemeStore.swift
//  Memorize_Final
//
//  Created by user211007 on 12/27/21.
//

import SwiftUI

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]()
    
    init(named name: String) {
        self.name = name
        if themes.isEmpty {
            print("using built-in themes")
            insertTheme(named: "Vehicles", color: .red, emojis: "✈️🚁🛶🚞🏍🚲🚘🚍🚀🛳🚛🚠🛺🚒🚜🦽🛴🛸⛵️🛩🛰🚂🦼🏎", numberOfPairsOfCards: 14)
            insertTheme(named: "Flags", color: .green, emojis: "🇦🇫🇦🇽🇩🇿🇦🇺🇦🇲🇧🇪🇨🇦🇧🇷🇵🇫🇫🇷🇱🇷🇯🇵🇯🇲🇯🇴🇰🇷🇪🇸🇹🇷🇬🇧🇾🇪", numberOfPairsOfCards: 10)
            insertTheme(named: "Animals", color: .purple, emojis: "🐼🐵🐣🦉🐴🐸🐷🐯🐻🦊🐶🐱🐭🐰", numberOfPairsOfCards: 8)
        }
    }
    
    func insertTheme(named name: String, color: Color, emojis: String?  = nil, numberOfPairsOfCards: Int = 0, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis ?? "", numberOfPairsOfCards: numberOfPairsOfCards, id: unique, rgbaColor: RGBAColor(color: color))
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
