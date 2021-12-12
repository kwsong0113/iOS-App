//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by user211007 on 12/12/21.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    
    var documentBody: some View {
        ZStack {
            Color.yellow
            ForEach(document.emojis) { emoji in
                Text(emoji.text)
                    .font(.system(size: fontSize(for: emoji)))
                    .position(position(for: emoji))
            }
        }
    }
    
    private func position(for emoji: EmojiArtModel.Emoji) -> CGPoint {
        
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    var palette: some View {
        ScrollingEmojisView(emojis: testemojis)
            .font(.system(size: defaultEmojiFontSize))
    }
    
    let testemojis = "😤😃🪳🐙💰🛼⚾️⏱🍎🧡➕🤬☂️✉️❌♻️🎤🍉⭐️🌙🐦👀🪡⚽️🎧🏓🎈📦🎱"
}

struct ScrollingEmojisView: View {
    let emojis: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                }
            }
        }
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
