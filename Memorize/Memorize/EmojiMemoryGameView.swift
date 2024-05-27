//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/6.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject
    var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2 / 3

    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            Button(action: {
                viewModel.shuffle()
            }, label: {
                Text("Shuffle")

            })
        }
        .padding()
    }

    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundStyle(.orange)
    }
}

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
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMathced ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: .init())
}
