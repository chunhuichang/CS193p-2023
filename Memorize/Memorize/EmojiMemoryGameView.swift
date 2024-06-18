//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/6.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject
    var viewModel: EmojiMemoryGame
    @State
    private var lastScoreChange = (0, causeByCardId: "")
    // Dealing from a Deck
    @State private var dealt = Set<Card.ID>()
    @Namespace private var dealingNamespace

    var body: some View {
        VStack {
            cards.foregroundStyle(viewModel.color)
            HStack {
                score
                Spacer()
                deck.foregroundStyle(viewModel.color)
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
    }
}

// MARK: - Card

private extension EmojiMemoryGameView {
    private var cards: some View {
        AspectVGrid(viewModel.cards, Constants.aspectRatio) { card in
            if isDealt(card) {
                cardAinimationView(card)
                    .padding(Constants.spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    // FIXME: xcode 15.3 can't display flying text front of the card
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }

    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causeByCardId: card.id)
        }
    }

    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

// MARK: - Bottom part

private extension EmojiMemoryGameView {
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }

    private var shuffle: some View {
        Button(action: {
            withAnimation {
                viewModel.shuffle()
            }
        }, label: {
            Text("Shuffle")

        })
    }
}

// MARK: - Dealing from a Deck

private extension EmojiMemoryGameView {
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }

    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                cardAinimationView(card)
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
        .onTapGesture {
            deal()
        }
    }

    private func cardAinimationView(_ card: Card) -> some View {
        CardView(card)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
    }

    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(Constants.dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += Constants.dealInterval
        }
    }
}

// MARK: - Constants

private extension EmojiMemoryGameView {
    private struct Constants {
        static let aspectRatio: CGFloat = 2 / 3
        static let spacing: CGFloat = 4
        static let deckWidth: CGFloat = 50
        static let dealAnimation: Animation = .easeInOut(duration: 1)
        static let dealInterval: TimeInterval = 0.15
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: .init())
}
