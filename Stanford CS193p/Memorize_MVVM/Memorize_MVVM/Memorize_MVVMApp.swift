//
//  Memorize_MVVMApp.swift
//  Memorize_MVVM
//
//  Created by user206692 on 11/17/21.
//

import SwiftUI

@main
struct Memorize_MVVMApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
