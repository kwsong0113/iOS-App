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
            }
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Theme Name").font(.subheadline)) {
            TextField("Name", text: $theme.name)
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
