//
//  ThemeChooser.swift
//  Memorize_Final
//
//  Created by user211007 on 12/29/21.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore

    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: ThemeEditor(theme: $store.themes[theme])) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .font(.title)
                                .foregroundColor(theme.color)
                            if theme.numberOfPairsOfCards == theme.emojis.count {
                                Text("All of \(theme.emojis)")
                                    .lineLimit(1)
                            } else {
                                Text("\(theme.numberOfPairsOfCards) pairs of \(theme.emojis)")
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem { EditButton() }
                ToolbarItem(placement: .navigationBarLeading) { addButton }
            }
            .environment(\.editMode, $editMode)
            .listStyle(PlainListStyle())
        }
    }
    
    var addButton: some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
            .environmentObject(ThemeStore(named: "Preview"))
    }
}
