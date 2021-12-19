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
        GeometryReader { geometry in
            ZStack {
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0, 0), in: geometry))
                )
                    .gesture(panGesture().simultaneously(with: doubleTapToZoom(in: geometry.size).exclusively(before: singleTapToDeselectAll())))
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    ForEach(document.emojis) { emoji in
                        Text(emoji.text)
                            .font(.system(size: fontSize(for: emoji)))
                            .scaleEffect(zoomScale)
                            .position(position(for: emoji, in: geometry))
                            .opacity(selected.contains(where: { $0.id == emoji.id }) ? 0.4 : 1)
                            .gesture(emojiPanGesture(emoji).simultaneously(with: selectGesture(emoji).exclusively(before: deleteGesture(emoji))))
                    }
                }
            }
            .clipped()
            .onDrop(of: [.plainText, .url, .image], isTargeted: nil) { providers, location in
                return drop(providers: providers, at: location, in: geometry)
            }
            .gesture(zoomGesture())
        }
    }
    
    @State private var selected = Set<EmojiArtModel.Emoji>()
    
    private func select(_ emoji: EmojiArtModel.Emoji) {
        selected.toggleMembership(of: emoji)
    }
    
    private func singleTapToDeselectAll() -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                withAnimation {
                    selected.removeAll()
                }
            }
    }
    
    @GestureState private var emojiPanGestureState: (EmojiArtModel.Emoji?, CGSize) = (nil, CGSize.zero)
    
    private func emojiPanGesture(_ emoji: EmojiArtModel.Emoji) -> some Gesture {
        DragGesture()
            .updating($emojiPanGestureState) { latestDragGestureValue, emojiPanGestureState, _ in
                emojiPanGestureState.0 = emoji
                emojiPanGestureState.1 = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                if selected.contains(where: { $0.id == emoji.id }) {
                    selected.forEach {
                        document.moveEmoji($0, by: finalDragGestureValue.translation / zoomScale)
                    }
                } else {
                    document.moveEmoji(emoji, by: finalDragGestureValue.translation / zoomScale)
                }
            }
    }
    
    private func deleteGesture(_ emoji: EmojiArtModel.Emoji) -> some Gesture {
        LongPressGesture()
            .onEnded {_ in
                withAnimation {
                    document.deleteEmoji(emoji)
                }
            }
    }
    
    private func selectGesture(_ emoji: EmojiArtModel.Emoji) -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                withAnimation {
                    select(emoji)
                }
            }
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(.url(url.imageURL))
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emoji = string.first, emoji.isEmoji {
                    document.addEmoji(
                        String(emoji),
                        at: convertToEmojiCoordinates(location, in: geometry),
                        size: defaultEmojiFontSize / zoomScale
                    )
                }
            }
        }
        return found
    }
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        if let draggingEmoji = emojiPanGestureState.0 {
            if draggingEmoji.id == emoji.id || (selected.contains(where: { $0.id == draggingEmoji.id }) && selected.contains(where: {$0.id == emoji.id })) {
                return convertFromEmojiCoordinates((emoji.x + Int(emojiPanGestureState.1.width), emoji.y + Int(emojiPanGestureState.1.height)), in: geometry)
            }
        }
        return convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: (location.x - panOffset.width - center.x) / zoomScale,
            y: (location.y - panOffset.height - center.y) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        if selected.contains(where: { $0.id == emoji.id }) {return gestureZoomScale * CGFloat(emoji.size) }
        else { return CGFloat(emoji.size) }
    }
    
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                if selected.isEmpty { gesturePanOffset = latestDragGestureValue.translation / zoomScale }
            }
            .onEnded { finalDragGestureValue in
                if selected.isEmpty { steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale) }
            }
    }
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    
    private var zoomScale: CGFloat {
        if selected.isEmpty { return steadyStateZoomScale * gestureZoomScale }
        else { return steadyStateZoomScale }
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                if selected.isEmpty { steadyStateZoomScale *= gestureScaleAtEnd }
                else {
                    selected.forEach {
                        document.scaleEmoji($0, by: gestureScaleAtEnd)
                    }
                }
            }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            steadyStateZoomScale = min(hZoom, vZoom)
        }
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
                        .onDrag { NSItemProvider(object: emoji as NSString) }
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
