//
//  ClickColorPicker.swift
//  Memorize_Final
//
//  Created by user211007 on 1/11/22.
//

import SwiftUI

struct ClickColorPicker: View {
    @Binding var selection: Color
    var colors: [Color] = [.red, .pink, .orange, .yellow, .green, .cyan, .blue, .indigo, .purple, .black]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            withAnimation {
                                selection = color
                            }
                        }
                        .padding(10)
                    if selection == Color(rgbaColor: RGBAColor(color: color)) {
                        Circle()
                            .stroke(color, lineWidth: 5)
                            .frame(width: 60, height: 60)
                    }
                }
            }
        }
    }
}
