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

#Preview {
    EmojiMemoryGameView(viewModel: .init())
}
