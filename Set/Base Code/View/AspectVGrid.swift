//
//  AspectVGrid.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 20/11/24.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    
    private struct Constant {
        static var spacing: CGFloat { 0 }
        static var padding: CGFloat { 10 }
        static var minimumItemWidth: CGFloat { 80 }
    }
    
    let items: [Item]
    let aspectRatio: CGFloat
    let content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let itemWidth = itemWidthThatFits(
                in: sizeByRemovingPadding(from: geometry.size),
                numberOfItems: items.count,
                aspectRatio: aspectRatio)
            
            let columns = [GridItem(.adaptive(minimum: max(itemWidth, Constant.minimumItemWidth)),
                                    spacing: Constant.spacing)]
            
            return ScrollView {
                LazyVGrid(columns: columns, spacing: Constant.spacing) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                .padding(Constant.padding)
            }
        }
    }
    
    /// Created in order to perfect animation of matches, which scale beyond its bounds
    private func sizeByRemovingPadding(from size: CGSize) -> CGSize {
        return CGSize(
            width: size.width - 2 * Constant.padding,
            height: size.height - 2 * Constant.padding)
    }
    
    private func itemWidthThatFits(in size: CGSize, numberOfItems: Int, aspectRatio: CGFloat) -> CGFloat {
        var numberOfColumns: CGFloat = 1
        let numberOfItems: CGFloat = CGFloat(numberOfItems)
        
        repeat {
            let itemWidth = size.width / numberOfColumns
            let itemHeight = itemWidth / aspectRatio
            let numberOfRows = (numberOfItems / numberOfColumns).rounded(.up)
            let totalHeight = itemHeight * numberOfRows
            if totalHeight < size.height {
                return (size.width / numberOfColumns).rounded(.down)
            }
            
            numberOfColumns += 1
        } while numberOfColumns <= numberOfItems
        
        return (size.height * aspectRatio).rounded(.down)
    }
}

#Preview {
    let cards = [
        Card(number: .one, shape: .one, color: .one, shading: .one, isFaceUp: true),
        Card(number: .two, shape: .two, color: .two, shading: .two, isFaceUp: true),
        Card(number: .three, shape: .three, color: .three, shading: .three, isFaceUp: true)
    ]
    
    AspectVGrid(cards, aspectRatio: 2/3) { card in
        CardView(card)
            .padding()
    }
}
