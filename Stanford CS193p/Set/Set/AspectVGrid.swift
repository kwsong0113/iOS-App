//
//  AspectVGrid.swift
//  Set
//
//  Created by user206692 on 11/28/21.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var itemIndices: Array<Int>
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(itemIndices: Array<Int>, items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.itemIndices = itemIndices
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(itemCount: itemIndices.count, in: geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(chosenItems()) {
                        content($0).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func chosenItems() -> [Item] {
        var chosenItems: [Item] = []
        itemIndices.forEach {
            chosenItems.append(items[$0])
        }
        return chosenItems
    }
}

private func adaptiveGridItem(width: CGFloat) -> GridItem {
    var gridItem = GridItem(.adaptive(minimum: width))
    gridItem.spacing = 0
    return gridItem
}

private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
    var columnCount = 1
    var rowCount = itemCount
    repeat {
        let itemWidth = size.width / CGFloat(columnCount)
        let itemHeight = itemWidth / itemAspectRatio
        if CGFloat(rowCount) * itemHeight < size.height {
            break
        }
        columnCount += 1
        rowCount = (itemCount + (columnCount - 1)) / columnCount
    } while columnCount < itemCount
    if columnCount > itemCount {
        columnCount = itemCount
    }
    return floor(size.width / CGFloat(columnCount))
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
