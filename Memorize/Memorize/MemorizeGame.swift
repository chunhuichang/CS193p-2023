//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/7.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0

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
            if !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
}

extension MemoryGame {
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var isFaceUp: Bool = false {
            didSet {
                if oldValue, !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }

        var hasBeenSeen: Bool = false
        var isMatched: Bool = false
        let content: CardContent

        var id: String
        var description: String {
            "\(id) \(content) \(isFaceUp ? "Up" : "Down") \(isMatched ? "Matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
