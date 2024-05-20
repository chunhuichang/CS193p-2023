//
//  Assignment2EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/13.
//

import SwiftUI

class Assignment2EmojiMemoryGame: ObservableObject {
    private(set) var theme: Assignment2Theme
    private(set) var color: Gradient
    @Published
    private var model: Assignment2MemorizeGame<String>
    @Published
    var isFinishedGame: Bool = false

    init() {
        self.theme = Assignment2Theme.allCases.randomElement() ?? .animal
        self.color = Assignment2Color.genGradient
        self.model = Assignment2EmojiMemoryGame.createMemoryGameWith(theme: theme)
    }

    private static func createMemoryGameWith(theme: Assignment2Theme) -> Assignment2MemorizeGame<String> {
        let emojis = theme.randomCards()
        return .init(numberOfPairsOfCards: emojis.count) { emojis.indices.contains($0) ? emojis[$0] : "⁉️" }
    }
}

// MARK: Input action

extension Assignment2EmojiMemoryGame {
    func startGame() {
        theme = Assignment2Theme.allCases.randomElement() ?? .animal
        color = Assignment2Color.genGradient
        model = Assignment2EmojiMemoryGame.createMemoryGameWith(theme: theme)
    }

    func choose(_ card: Assignment2MemorizeGame<String>.Card) {
        model.choose(card: card)
        isFinishedGame = model.allCardsMatched
    }
}

// MARK: Output event

extension Assignment2EmojiMemoryGame {
    var cards: [Assignment2MemorizeGame<String>.Card] {
        model.cards
    }

    var scores: Int {
        model.scores
    }
}
