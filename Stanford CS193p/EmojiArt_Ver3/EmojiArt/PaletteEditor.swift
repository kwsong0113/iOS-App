//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by user211007 on 12/25/21.
//

import SwiftUI

struct PaletteEditor: View {
    @Binding var palette: Palette
    var body: some View {
        Form {
            TextField("Name", text: $palette.name)
        }
        .frame(minWidth: 300, minHeight: 350)
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        Text("Fix me")
//        PaletteEditor()
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/))
    }
}
