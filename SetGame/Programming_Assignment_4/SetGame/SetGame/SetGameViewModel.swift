//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Jill Chang on 2024/7/8.
//

import Foundation
import SwiftUICore

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    @Published
    private var model = SetGame()
    var isGameOver = false
    
    var tableCards: [Card] {
        model.cards
    }
    
    var deckCards: [Card] {
        model.deck
    }
    
    var discardCards: [Card] {
        model.discardPile
    }
    
    var score: Int {
        model.score
    }
    
    var deckCardColor: Color {
        .orange
    }
    
    func selectCard(_ card: Card) {
        model.selectCard(card)
        isGameOver = model.isGameOver
    }
    
    func dealMoreCards() {
        if tableCards.isEmpty {
            model.dealInitCards()
        } else {
            model.dealThreeMoreCards()
        }
    }
    
    func newGame() {
        model = SetGame()
    }
    
    func hint() -> Set<SetGame.Card> {
        model.getHintCards()
    }

    func shuffleDeckCard() {
        model.reshuffle()
    }
}
