//
//  Assignment2EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/13.
//

import SwiftUI

struct Assignment2EmojiMemoryGameView: View {
    @ObservedObject
    var viewModel: Assignment2EmojiMemoryGame

    let emojis = ["😈", "👹", "👻", "💀", "👺", "🎃", "🧛🏻‍♂️", "🧟‍♂️", "🕷️", "🦹"]

    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button(action: {
                viewModel.shuffle()
            }, label: {
                Text("Shuffle")

            })
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                Assignment2EmojiMemoryGameView.CardView(card)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(.orange)
    }

    struct CardView: View {
        let card: Assignment2MemorizeGame<String>.Card

        init(_ card: Assignment2MemorizeGame<String>.Card) {
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
}

#Preview {
    Assignment2EmojiMemoryGameView(viewModel: .init())
}