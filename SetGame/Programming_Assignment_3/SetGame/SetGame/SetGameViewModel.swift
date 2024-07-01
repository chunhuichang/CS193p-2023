//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/26.
//

import Foundation

class SetGameViewModel: ObservableObject {
    @Published
    private var model = SetGame()
    var isGameOver = false
    
    var cards: [SetGame.Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var deckIsEmpty: Bool {
        model.deck.isEmpty
    }
    
    func selectCard(_ card: SetGame.Card) {
        model.selectCard(card)
        // TODO: check game is over?
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
    
    func newGame() {
        model = SetGame()
    }
}
