//
//  ThemeEditor.swift
//  Memorize_Final
//
//  Created by user211007 on 12/29/21.
//

import SwiftUI

struct ThemeEditor: View {
    @EnvironmentObject var store: ThemeStore
    
    @Binding var theme: Theme {
        didSet {
            store.updateGame(theme: theme)
            print("didSet theme")
        }
    }
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack {
                Text(theme.name)
                    .bold()
                HStack {
                    Spacer()
                    doneButton
                }
            }
            .padding([.horizontal, .top])
            .padding([.bottom], 4)
            Form {
                nameSection
                addEmojisSection
                removeEmojisSection
                cardCountSection
                colorSection
            }
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Theme Name").font(.callout).bold()) {
            TextField("Name", text: $theme.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis").font(.callout).bold()) {
            TextField("Emoji", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: ZStack(alignment: .leading) {
            Text("Remove Emojis").font(.callout).bold()
            HStack {
                Spacer()
                Text("Tap Emoji to Exclude").font(.footnote)
            }
        }) {
        let emojis = theme.emojis.removingDuplicateCharacters.map { String($0) }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                if (theme.numberOfPairsOfCards > 2) { theme.numberOfPairsOfCards = min(theme.emojis.count - 1, theme.numberOfPairsOfCards) }
                                theme.emojis.removeAll(where: { String($0) == emoji })
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
    var cardCountSection: some View {
        Section(header: Text("Card Count").font(.callout).bold()) {
            Stepper {
                Text("\(theme.numberOfPairsOfCards) pairs")
            } onIncrement: {
                if (theme.numberOfPairsOfCards >= theme.emojis.count) {
                    theme.numberOfPairsOfCards = theme.numberOfPairsOfCards
                } else { theme.numberOfPairsOfCards += 1 }
            } onDecrement: {
                if (theme.numberOfPairsOfCards <= 2) { theme.numberOfPairsOfCards = 2 }
                else { theme.numberOfPairsOfCards -= 1}
            }
        }
    }
    
    var colorSection: some View {
        Section(header: Text("Color").font(.callout).bold()) {
            ClickColorPicker(selection: $theme.color)
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            theme.emojis = (emojis + theme.emojis)
                .filter({ $0.isEmoji })
                .removingDuplicateCharacters
        }
    }
    
    var doneButton: some View {
        Button("Done") {
            withAnimation {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .disabled(theme.emojis.count < 2 || theme.numberOfPairsOfCards < 2 || theme.numberOfPairsOfCards > theme.emojis.count)
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore(named: "Preview").theme(at: 0)))
    }
}
