//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/7.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []

        // add numberOfPairsOfCards * 2
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    mutating func shuffle() {
        cards.shuffle()
    }

    func choose(card: Card) {}
}

extension MemoryGame {
    struct Card {
        var isFaceUp: Bool = false
        var isMathced: Bool = false
        let content: CardContent
    }
}
