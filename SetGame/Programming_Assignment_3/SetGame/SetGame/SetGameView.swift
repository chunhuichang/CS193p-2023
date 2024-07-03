//
//  SetGameView.swift
//  SetGame
//
//  Created by Jill Chang on 2024/6/24.
//

import CoreComponent
import SwiftUI

struct SetGameView: View {
    @ObservedObject
    var viewModel: SetGameViewModel
    @State
    private var isGameOver = true
    @State
    private var hint: Set<SetGame.Card> = []

    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
                .font(.headline)
            cards
            buttons.padding(.vertical)
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

// MARK: - Cards

private extension SetGameView {
    private var cards: some View {
        AspectVGrid(viewModel.cards, Constants.aspectRatio) { card in
            CardView(card: card, isHint: hint.contains(card))
                .padding(Constants.spacing)
                .onTapGesture {
                    viewModel.selectCard(card)
                }
        }
    }

    private struct Constants {
        static let aspectRatio: CGFloat = 2 / 3
        static let spacing: CGFloat = 4
    }
}

// MARK: - Buttons

private extension SetGameView {
    var buttons: some View {
        HStack {
            Button("New Game") {
                viewModel.newGame()
            }
            .buttonStyle(BorderedButtonStyle())
            Spacer()
            Button("Hint") {
                hint = viewModel.hint()
            }
            .buttonStyle(BorderedButtonStyle())
            Spacer()
            Button("Deal 3 More Cards") {
                viewModel.dealThreeMoreCards()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .disabled(viewModel.deckIsEmpty)
        }
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
