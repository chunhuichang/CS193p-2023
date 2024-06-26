//
//  CardView.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/26.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card

    var body: some View {
        GeometryReader { geometry in
            let symbolSize = symbolSize(in: geometry)
            ZStack {
                cardContents(size: symbolSize)
                    .cardify(isSelected: card.isSelected)
            }
        }
    }

    private func cardContents(size: CGSize) -> some View {
        VStack {
            ForEach(0 ..< card.number.rawValue, id: \.self) { _ in
                symbol.frame(width: size.width, height: size.height)
            }
        }

        .foregroundColor(card.color.color)
    }

    private func symbolSize(in geometry: GeometryProxy) -> CGSize {
        let width = geometry.size.width * Constants.symbolWidthRatio
        let height = width * Constants.symbolAspectRatio
        return CGSize(width: width, height: height)
    }

    @ViewBuilder
    private var symbol: some View {
        switch card.shape {
        case .diamond:
            // TODO: Impelment Diamond shape
            applyShading(to: Rectangle())
        case .squiggle:
            applyShading(to: Rectangle())
        case .oval:
            applyShading(to: Capsule())
        }
    }

    @ViewBuilder
    private func applyShading(to shape: some Shape) -> some View {
        let shading = card.shading
        let color = card.color.color
        switch shading {
        case .solid:
            shape.fill(color)
        case .striped:
            shape.fill(color.opacity(Constants.stripedOpacity))
        case .open:
            shape.stroke(color, lineWidth: Constants.openLineWidth)
        }
    }

    private struct Constants {
        static let stripedOpacity: CGFloat = 0.3
        static let openLineWidth: CGFloat = 2
        static let symbolAspectRatio: CGFloat = 1 / 3
        static let symbolWidthRatio: CGFloat = 0.7
    }
}
