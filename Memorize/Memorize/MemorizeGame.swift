//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/7.
//

import Foundation

struct MemoryGame<CardContent> {
    struct Card {
        var isFaceUp: Bool
        var isMathced: Bool
        var content: CardContent
    }

    var cards: [Card] = []

    func choose(card: Card) {}
}
