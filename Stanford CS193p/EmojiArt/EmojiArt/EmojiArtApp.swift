//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by user211007 on 12/12/21.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
