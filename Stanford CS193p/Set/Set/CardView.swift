//
//  CardView.swift
//  Set
//
//  Created by user206692 on 11/30/21.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGameViewModel.Card
    let card: Card
    
    var cardNumber: Int {
        return card.number.rawValue
    }
    
    var cardColor: Color {
        switch card.color.rawValue {
        case 1: return .red
        case 2: return .blue
        default: return .green
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 15)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                VStack (spacing: 0) {
                    let paddingLength: CGFloat = geometry.size.height * 0.35 / CGFloat(cardNumber) - geometry.size.width * 0.15
                    Spacer(minLength: geometry.size.height * 0.15)
                    ForEach(0..<cardNumber) { _ in
                        cardShape()
                            .padding(.horizontal, geometry.size.width * 0.2)
                            .padding(.vertical, paddingLength)
                    }
                    Spacer(minLength: geometry.size.height * 0.15)
//                    Text("\(card.number.rawValue)")
//                    Text("\(card.shape.rawValue)")
//                    Text("\(card.shading.rawValue)")
//                    Text("\(card.color.rawValue)")
                }
                .font(.footnote)
                .foregroundColor(cardColor)
            }
        }
    }
    
    @ViewBuilder
    func cardShape() -> some View {
        switch card.shape.rawValue {
        case 1: cardShading(shape: Diamond())
        case 2: cardShading(shape: Rectangle())
        default: cardShading(shape: Ellipse())
        }
    }
    
    @ViewBuilder
    func cardShading<SomeShape>(shape: SomeShape) -> some View where SomeShape: Shape {
        switch card.shape.rawValue {
        case 1: shape.stroke(lineWidth: 2)
        case 2: ZStack {
            shape.fill().opacity(0.8)
            shape.stroke(lineWidth: 2)
            }
        default: ZStack {
            shape.fill().opacity(0.1)
            shape.stroke(lineWidth: 2)
            }
        }
    }
}
