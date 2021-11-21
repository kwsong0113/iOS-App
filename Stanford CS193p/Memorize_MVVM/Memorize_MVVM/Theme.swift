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
    Theme(name: "Vehicles", emojis: ["✈️", "🚁", "🛶", "🚞", "🏍", "🚲", "🚘", "🚍", "🚀", "🛳", "🚛", "🚠", "🛺", "🚒", "🚜", "🦽", "🛴", "🛸", "⛵️", "🛩", "🛰", "🚂", "🦼", "🏎"], color: "red"),
    Theme(name: "Flags", emojis: ["🇦🇫", "🇦🇽", "🇩🇿", "🇦🇺", "🇦🇲", "🇧🇪", "🇨🇦", "🇧🇷", "🇵🇫", "🇫🇷", "🇱🇷", "🇯🇵", "🇯🇲", "🇯🇴", "🇰🇷", "🇪🇸", "🇹🇷", "🇬🇧", "🇾🇪"], color: "green"),
    Theme(name: "Animals", emojis: ["🐼", "🐵", "🐣", "🦉", "🐴", "🐸", "🐷", "🐯", "🐻", "🦊", "🐶", "🐱", "🐭", "🐰"], color: "purple")
]
