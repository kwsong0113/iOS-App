//
//  Memorize_AnimationApp.swift
//  Memorize_Animation
//
//  Created by user206692 on 12/4/21.
//

import SwiftUI

@main
struct Memorize_AnimationApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
