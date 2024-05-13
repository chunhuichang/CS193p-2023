//
//  Assignment2EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/13.
//

import SwiftUI

class Assignment2EmojiMemoryGame: ObservableObject {
    private static let emojis = ["😈", "👹", "👻", "💀", "👺", "🎃", "🧛🏻‍♂️", "🧟‍♂️", "🕷️", "🦹"]

    private static func createMemoryGame() -> Assignment2MemorizeGame<String> {
        .init(numberOfPairsOfCards: 4) { pairIndex in
            emojis.indices.contains(pairIndex) ? emojis[pairIndex] : "⁉️"
        }
    }

    @Published
    private var model: Assignment2MemorizeGame<String> = createMemoryGame()

    var cards: [Assignment2MemorizeGame<String>.Card] {
        model.cards
    }

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: Assignment2MemorizeGame<String>.Card) {
        model.choose(card: card)
    }
}
