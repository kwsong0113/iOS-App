//
//  Theme.swift
//  Memorize_MVVM
//
//  Created by user206692 on 11/21/21.
//

import Foundation

struct Theme<ThemeContent> {
    private(set) var name: String
    private(set) var numberOfPairsOfCards: Int?
    private(set) var emojis: Array<ThemeContent>
    private(set) var color: String
}

let themes: Array<Theme<String>> = [
    Theme(name: "Vehicles", emojis: ["βοΈ", "π", "πΆ", "π", "π", "π²", "π", "π", "π", "π³", "π", "π ", "πΊ", "π", "π", "π¦½", "π΄", "πΈ", "β΅οΈ", "π©", "π°", "π", "π¦Ό", "π"], color: "red"),
    Theme(name: "Flags", emojis: ["π¦π«", "π¦π½", "π©πΏ", "π¦πΊ", "π¦π²", "π§πͺ", "π¨π¦", "π§π·", "π΅π«", "π«π·", "π±π·", "π―π΅", "π―π²", "π―π΄", "π°π·", "πͺπΈ", "πΉπ·", "π¬π§", "πΎπͺ"], color: "green"),
    Theme(name: "Animals", emojis: ["πΌ", "π΅", "π£", "π¦", "π΄", "πΈ", "π·", "π―", "π»", "π¦", "πΆ", "π±", "π­", "π°"], color: "purple")
]
