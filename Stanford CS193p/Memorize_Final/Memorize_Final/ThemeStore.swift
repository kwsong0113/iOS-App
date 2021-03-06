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
    var games = Dictionary<Int, EmojiMemoryGame>()
    
    init(named name: String) {
        self.name = name
        if themes.isEmpty {
            print("using built-in themes")
            insertTheme(named: "Vehicles", color: .red, emojis: "βοΈππΆπππ²ππππ³ππ πΊπππ¦½π΄πΈβ΅οΈπ©π°ππ¦Όπ", numberOfPairsOfCards: 12)
            insertTheme(named: "Flags", color: .green, emojis: "π¦π«π¦π½π©πΏπ¦πΊπ¦π²π§πͺπ¨π¦π§π·π΅π«π«π·π±π·π―π΅π―π²π―π΄π°π·πͺπΈπΉπ·π¬π§πΎπͺ", numberOfPairsOfCards: 10)
            insertTheme(named: "Animals", color: .purple, emojis: "πΌπ΅π£π¦π΄πΈπ·π―π»π¦πΆπ±π­π°", numberOfPairsOfCards: 14)
        }
    }
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    @discardableResult
    func insertTheme(named name: String, color: Color, emojis: String?  = nil, numberOfPairsOfCards: Int = 0, at index: Int = 0) -> Theme {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis ?? "", numberOfPairsOfCards: numberOfPairsOfCards, id: unique, rgbaColor: RGBAColor(color: color))
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
        updateGame(theme: theme)
        return theme
    }
    
    func updateGame(theme: Theme) {
        if (theme.numberOfPairsOfCards <= theme.emojis.count) {
            games[theme.id] = EmojiMemoryGame(theme: theme)
        }
    }
    
    func updateAllGamesExcept(theme: Theme) {
        themes.forEach {
            if ($0.id != theme.id) { updateGame(theme: $0) }
        }
    }
}
