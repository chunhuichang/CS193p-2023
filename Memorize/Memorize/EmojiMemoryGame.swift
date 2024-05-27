//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/7.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["😈", "👹", "👻", "💀", "👺", "🎃", "🧛🏻‍♂️", "🧟‍♂️", "🕷️", "🦹"]

    private static func createMemoryGame() -> MemoryGame<String> {
        .init(numberOfPairsOfCards: 4) { pairIndex in
            emojis.indices.contains(pairIndex) ? emojis[pairIndex] : "⁉️"
        }
    }

    @Published
    private var model: MemoryGame<String> = createMemoryGame()

    var cards: [Card] {
        model.cards
    }

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: Card) {
        model.choose(card: card)
    }
}
