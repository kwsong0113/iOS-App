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
    @ObservedObject var viewModel: SetGameViewModel
    
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
    
    var isSelected: Bool {
        return viewModel.selectedCardsIndex.contains(where: { viewModel.deck[$0].id == card.id })
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: geometry.size.width * 0.2)
                shape.fill().foregroundColor(isSelected ? .yellow : .white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(isSelected && viewModel.selectedCardsIndex.count == 3 ? (viewModel.selectedCardsMatched ? .blue : .red) : .black)
                VStack (spacing: 0) {
                    ForEach(0..<cardNumber) { _ in
                        cardShape()
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.3)
                            .padding(.vertical, geometry.size.height * 0.03)
                    }
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
        switch card.shading.rawValue {
        case 1: shape.stroke(lineWidth: 2)
        case 2: ZStack {
            shape.fill().opacity(0.8)
            shape.stroke(lineWidth: 2)
            }
        default: ZStack {
            shape.fill().opacity(0.2)
            shape.stroke(lineWidth: 2)
            }
        }
    }
}
