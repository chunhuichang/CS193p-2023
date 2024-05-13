//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/7.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []

        // add numberOfPairsOfCards * 2
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }

    mutating func shuffle() {
        cards.shuffle()
    }

    func choose(card: Card) {
        print("choose \(card)")
    }
}

extension MemoryGame {
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var isFaceUp: Bool = true
        var isMathced: Bool = false
        let content: CardContent

        var id: String
        var description: String {
            "\(id) \(content) \(isFaceUp ? "Up" : "Down") \(isMathced ? "Matched" : "")"
        }
    }
}
