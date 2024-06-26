//
//  SetGame.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/24.
//

import Foundation

struct SetGame {
    private(set) var cards: [Card] = []
    private(set) var deck: [Card] = []
    private(set) var score: Int = 0

    init() {
        deck = genAllCards()
        deck.shuffle()
        cards = Array(deck.prefix(12))
        deck.removeFirst(12)
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
            case red, green, blue
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
