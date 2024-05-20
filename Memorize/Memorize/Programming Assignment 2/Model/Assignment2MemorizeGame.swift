//
//  Assignment2MemorizeGame.swift
//  Memorize
//
//  Created by Jill Chang on 2024/5/13.
//

import Foundation

struct Assignment2MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var scores = 0
    private var matchCards = [Int]()

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []

        // add numberOfPairsOfCards * 2
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
        cards.shuffle()
    }
}

// MARK: - Input Action

extension Assignment2MemorizeGame {
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = newValue == $0 }
        }
    }

    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    for index in [chosenIndex, potentialMatchIndex] {
                        cards[index].isMatched = true
                    }
                    scores += 2
                } else {
                    for index in [chosenIndex, potentialMatchIndex] {
                        if matchCards.contains(index) {
                            scores -= 1
                        } else {
                            matchCards.append(index)
                        }
                    }
                }
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
}

// MARK: Output event

extension Assignment2MemorizeGame {
    var allCardsMatched: Bool {
        cards.allSatisfy(\.isMatched)
    }
}

// MARK: - Card

extension Assignment2MemorizeGame {
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        let content: CardContent

        var id: String
        var description: String {
            "\(id) \(content) \(isFaceUp ? "Up" : "Down") \(isMatched ? "Matched" : "")"
        }
    }
}
