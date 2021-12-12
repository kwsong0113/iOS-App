//
//  Cardify.swift
//  Animated Set
//
//  Created by user211007 on 12/11/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool, isSelected: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isSelected = isSelected
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue}
    }

    var isSelected: Bool
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: geometry.size.width * 0.2)
                if rotation < 90 {
                    shape.fill().foregroundColor(isSelected ? .yellow : .white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                } else {
                    shape.fill().foregroundColor(.gray)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                }
                content
                    .opacity(rotation < 90 ? 1 : 0)
            }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
        }
    }
    
    private struct DrawingConstants {
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected))
    }
}
