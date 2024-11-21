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
        static var minimumItemWidth: CGFloat { 90 }
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
                in: geometry.size,
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
            }
        }
    }
    
    func itemWidthThatFits(in size: CGSize, numberOfItems: Int, aspectRatio: CGFloat) -> CGFloat {
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
        Card(content: "👑", isSelected: true),
        Card(content: "👑", isSelected: false)
    ]
    
    AspectVGrid(cards, aspectRatio: 2/3) { card in
        CardView(card)
            .padding()
    }
}
