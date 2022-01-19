//
//  EmojiArt_Ver4App.swift
//  EmojiArt_Ver4
//
//  Created by user211007 on 1/17/22.
//

import SwiftUI

@main
struct EmojiArt_Ver4App: App {
    @StateObject var document = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
                .environmentObject(paletteStore)
        }
    }
}
