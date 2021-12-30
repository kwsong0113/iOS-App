//
//  ThemeEditor.swift
//  Memorize_Final
//
//  Created by user211007 on 12/29/21.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
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
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: ZStack(alignment: .leading) {
            Text("Remove Emojis").bold()
            HStack {
                Spacer()
                Text("Tap Emoji to Exclude").font(.footnote)
            }
        }
        .font(.callout)
        ) {
        let emojis = theme.emojis.removingDuplicateCharacters.map { String($0) }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
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
                theme.numberOfPairsOfCards += 1
            } onDecrement: {
                theme.numberOfPairsOfCards -= 1
            }
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
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore(named: "Preview").theme(at: 0)))
    }
}
