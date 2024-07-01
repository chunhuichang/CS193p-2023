//
//  SetGame.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/24.
//

import Foundation
import SwiftUICore

struct SetGame {
    private(set) var cards: [Card] = []
    private(set) var deck: [Card] = []
    private(set) var score: Int = 0

    init() {
        deck = genAllCards()
        deck.shuffle()
        cards = drawCardsFromDeck(12)
    }

    // MARK: - Bonus Time

    var lastMatchTime: Date?
}

// MARK: - Select Card

extension SetGame {
    mutating func selectCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isSelected.toggle()
            let selectedCards = cards.filter(\.isSelected)
            if selectedCards.count == 3 {
                if isSet(selectedCards) {
                    score += 3
                    
                    // Calculate Bonus Score
                    if let lastTime = lastMatchTime, Date().timeIntervalSince(lastTime) < 5 {
                        score += 5
                    }
                    lastMatchTime = Date()
                    
                    var drawCards = drawCardsFromDeck()
                    for selectedCard in selectedCards {
                        if let selectedIndex = cards.firstIndex(where: { $0.id == selectedCard.id }) {
                            if drawCards.isEmpty {
                                cards.remove(at: selectedIndex)
                            } else {
                                cards[selectedIndex] = drawCards.removeFirst()
                            }
                        }
                    }
                } else {
                    score = max(0, score - 1)

                    let selectedCardIndexs = cards.enumerated().filter { $1.isSelected }.map(\.offset)
                    for selectedIndex in selectedCardIndexs {
                        cards[selectedIndex].isSelected = false
                    }
                }
            }
        }
    }
}

// MARK: - Deal Three More Cards

extension SetGame {
    mutating func dealThreeMoreCards() {
        cards.append(contentsOf: drawCardsFromDeck())
    }
}

// MARK: - Private function

private extension SetGame {
    mutating func drawCardsFromDeck(_ count: Int = 3) -> [Card] {
        guard !deck.isEmpty else {
            return []
        }
        let drawCards = Array(deck.prefix(count))
        deck.removeFirst(count)
        return drawCards
    }

    func isSet(_ cards: [Card]) -> Bool {
        guard cards.count == 3 else {
            return false
        }
        return isTypeSet(cards.map(\.color)) &&
            isTypeSet(cards.map(\.shape)) &&
            isTypeSet(cards.map(\.number)) &&
            isTypeSet(cards.map(\.shading))
    }

    func isTypeSet(_ types: [some Hashable]) -> Bool {
        Set(types).count != 2
    }
}

extension SetGame {
    struct Card: Identifiable {
        let id = UUID()
        let color: CardColor
        let shape: CardShape
        let number: CardNumber
        let shading: CardShading
        var isSelected = false

        enum CardColor: CaseIterable {
            case red
            case green
            case blue

            var color: Color {
                switch self {
                case .red:
                    .red
                case .green:
                    .green
                case .blue:
                    .blue
                }
            }
        }

        enum CardShape: CaseIterable {
            case diamond, squiggle, oval
        }

        enum CardNumber: Int, CaseIterable {
            case one = 1
            case two = 2
            case three = 3
        }

        enum CardShading: CaseIterable {
            case solid, striped, open
        }

        // MARK: - Bonus Time

        var lastMatchTime: Date?
    }
}

private extension SetGame {
    func genAllCards() -> [Card] {
        var allCards: [Card] = []
        for color in Card.CardColor.allCases {
            for shape in Card.CardShape.allCases {
                for number in Card.CardNumber.allCases {
                for shading in Card.CardShading.allCases {
                        allCards.append(Card(color: color, shape: shape, number: number, shading: shading))
                    }
                }
            }
        }
        return allCards
    }
}
