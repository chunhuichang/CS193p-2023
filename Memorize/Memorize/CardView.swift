//
//  CardView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/27.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card

    init(_ card: Card) {
        self.card = card
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }

        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }

    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            }
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMathced ? 1 : 0)
    }
}

#Preview {
    typealias Card = CardView.Card
    return VStack {
        HStack {
            CardView(Card(content: "X", id: "a"))
            CardView(Card(isFaceUp: true, content: "This is VERY VERY VERY VERY VERY LONG content.", id: "a"))
        }
        HStack {
            CardView(Card(isMathced: true, content: "X", id: "a"))
            CardView(Card(isFaceUp: true, isMathced: true, content: "X", id: "a"))
        }
    }
    .padding()
    .foregroundStyle(.green)
}
