//
//  Assignment2MemorizeGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/13.
//

import Foundation

struct Assignment2MemorizeGame<CardContent> where CardContent: Equatable {
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

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = newValue == $0 }
        }
    }

    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMathced {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMathced = true
                        cards[potentialMatchIndex].isMathced = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
}

extension Assignment2MemorizeGame {
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var isFaceUp: Bool = false
        var isMathced: Bool = false
        let content: CardContent

        var id: String
        var description: String {
            "\(id) \(content) \(isFaceUp ? "Up" : "Down") \(isMathced ? "Matched" : "")"
        }
    }
}
