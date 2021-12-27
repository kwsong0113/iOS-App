//
//  Memorize_FinalApp.swift
//  Memorize_Final
//
//  Created by user211007 on 12/27/21.
//

import SwiftUI

@main
struct Memorize_FinalApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}