//
//  AspectVGrid.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/26.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView

    init(_ items: [Item], _ aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: items.count, size: geometry.size, atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }

    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0

        repeat {
            let width = size.width / columnCount
            let height = width / atAspectRatio

            let rowColumn = (count / columnCount).rounded(.up)

            if height * rowColumn < size.height {
                return width.rounded(.down)
            }

            columnCount += 1
        } while columnCount < count

        return min(size.width / columnCount, size.height * atAspectRatio).rounded(.down)
    }
}
