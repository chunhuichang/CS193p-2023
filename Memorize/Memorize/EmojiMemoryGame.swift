//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/7.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["😈", "👹", "👻", "💀", "👺", "🎃", "🧛🏻‍♂️", "🧟‍♂️", "🕷️", "🦹"]

    private static func createMemoryGame() -> MemoryGame<String> {
        .init(numberOfPairsOfCards: 4) { pairIndex in
            emojis.indices.contains(pairIndex) ? emojis[pairIndex] : "⁉️"
        }
    }

    private var model: MemoryGame<String> = createMemoryGame()

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {}
}
