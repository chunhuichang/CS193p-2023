//
//  ContentView.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var viewModel: SetGameViewModel
    
    @State var isGameOver = true
    
    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
                .font(.headline)
            // TODO: Display Cards
            HStack {
                Button("New Game") {
                    viewModel.newGame()
                }
                .buttonStyle(BorderedButtonStyle())
                Spacer()
                Button("Deal 3 More Cards") {
                    viewModel.dealThreeMoreCards()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(viewModel.deckIsEmpty)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $viewModel.isGameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("You scored \(viewModel.score) points!"),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.newGame()
                })
            )
        }
    }
}

#Preview {
    ContentView(viewModel: SetGameViewModel())
}

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
        // TODO: model.selectCard(card)
        // TODO: check game is over?
    }
    
    func dealThreeMoreCards() {
        // TODO: model.dealThreeMoreCards()
    }
    
    func newGame() {
        model = SetGame()
    }
}
