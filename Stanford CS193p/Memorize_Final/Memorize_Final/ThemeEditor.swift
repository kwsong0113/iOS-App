//
//  ThemeEditor.swift
//  Memorize_Final
//
//  Created by user211007 on 12/29/21.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    var body: some View {
        Text("Hello, world!")
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore(named: "Preview").theme(at: 1)))
    }
}
