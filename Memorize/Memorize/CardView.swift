//
//  CardView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/27.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2.0)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMathced ? 1 : 0)
    }
}

#Preview {
    VStack {
        HStack {
            CardView(MemoryGame<String>.Card(content: "X", id: "a"))
            CardView(MemoryGame<String>.Card(isFaceUp: true, content: "This is VERY VERY VERY VERY VERY LONG content.", id: "a"))
        }
        HStack {
            CardView(MemoryGame<String>.Card(isMathced: true, content: "X", id: "a"))
            CardView(MemoryGame<String>.Card(isFaceUp: true, isMathced: true, content: "X", id: "a"))
        }
    }
    .padding()
    .foregroundStyle(.green)
}